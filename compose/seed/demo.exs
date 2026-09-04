defmodule XiangjianDemoSeed do
  alias Rice.Accounts
  alias Rice.Accounts.User
  alias Rice.Grains
  alias Rice.PDS
  alias Rice.Repo
  alias Rice.Tasks

  @alice "alice.uat.test"
  @bob "bob.uat.test"

  def run do
    # ponytail: one marker is enough for this disposable demo; reset volumes after a partial seed.
    if Repo.get_by(User, handle: @alice) do
      IO.puts("demo data already exists")
    else
      seed()
    end
  end

  defp seed do
    password = System.fetch_env!("MOCK_ACCOUNT_PASSWORD")
    alice = register(@alice, "阿禾", "alice@uat.invalid", password)
    bob = register(@bob, "木川", "bob@uat.invalid", password)

    Grains.grant(alice, 500, memo: "Demo 初始稻米") |> ok!("grant Alice")
    Grains.grant(bob, 200, memo: "Demo 初始稻米") |> ok!("grant Bob")

    Tasks.create_task(alice, %{
      title: "[Demo] 记录村口古树故事",
      description: "访谈一位村民并整理一段口述记录。",
      reward_amount: 80,
      application_deadline: DateTime.add(DateTime.utc_now(), 30, :day)
    })
    |> ok!("create task")

    alice_session = PDS.create_session(@alice, password) |> ok!("login Alice")
    bob_session = PDS.create_session(@bob, password) |> ok!("login Bob")

    PDS.put_profile(alice_session["accessJwt"], alice_session["did"], %{
      "displayName" => "阿禾",
      "description" => "关注乡村记忆和社区共创。"
    })
    |> ok!("write Alice profile")

    PDS.put_profile(bob_session["accessJwt"], bob_session["did"], %{
      "displayName" => "木川",
      "description" => "做地图，也做一点农田水利调查。"
    })
    |> ok!("write Bob profile")

    create_post(
      alice_session,
      "demo-alice-welcome",
      "乡建 Demo 广场开张，欢迎记录村庄里的小发现。 #乡建",
      "post"
    )

    create_post(
      bob_session,
      "demo-bob-activity",
      "周六一起整理老粮站的口述资料。 #社区共创",
      "activity"
    )

    IO.puts("demo data is ready")
  end

  defp register(handle, nickname, email, password) do
    Accounts.register(%{
      handle: handle,
      nickname: nickname,
      email: email,
      password: password
    })
    |> ok!("create #{handle}")
    |> Map.fetch!(:user)
  end

  defp create_post(session, rkey, text, category) do
    response =
      Req.post(
        System.fetch_env!("PDS_BASE_URL") <> "/xrpc/com.atproto.repo.createRecord",
        auth: {:bearer, session["accessJwt"]},
        json: %{
          "repo" => session["did"],
          "collection" => "app.bsky.feed.post",
          "rkey" => rkey,
          "record" => %{
            "$type" => "app.bsky.feed.post",
            "text" => text,
            "langs" => ["zh"],
            "xjdaoCategory" => category,
            "createdAt" => DateTime.utc_now() |> DateTime.to_iso8601()
          }
        },
        receive_timeout: 20_000
      )

    case response do
      {:ok, %{status: status}} when status in 200..299 -> :ok
      other -> raise "create post failed: #{inspect(other)}"
    end
  end

  defp ok!({:ok, value}, _label), do: value
  defp ok!({:error, reason}, label), do: raise("#{label} failed: #{inspect(reason)}")
end
