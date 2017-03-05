# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lift,
  ecto_repos: [Lift.Repo]

# Configures the endpoint
config :lift, Lift.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p+FAdQOm8a8r3O/mp+c0jp7kGrihWkHEM7dMrlaQOGYibX++fA+H6AZhgaTIsNr6",
  render_errors: [view: Lift.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lift.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Lift.User,
  repo: Lift.Repo,
  module: Lift,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:trackable, :invitable, :rememberable, :authenticatable, :recoverable, :lockable, :unlockable_with_token, :registerable]

config :coherence, Lift.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
