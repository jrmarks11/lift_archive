Code.ensure_loaded Phoenix.Swoosh

defmodule Lift.Coherence.UserEmail do
  use Phoenix.Swoosh, view: Coherence.EmailView, layout: {Coherence.LayoutView, :email}
  alias Swoosh.Email
  require Logger
  alias Coherence.Config

  defp site_name, do: Config.site_name(inspect Config.module)

  def password(user, url) do
    %Email{}
    |> from(from_email)
    |> to(user_email(user))
    |> add_reply_to
    |> subject("#{site_name} - Reset password instructions")
    |> render_body("password.html", %{url: url, name: first_name(user.name)})
  end

  def confirmation(user, url) do
    %Email{}
    |> from(from_email)
    |> to(user_email(user))
    |> add_reply_to
    |> subject("#{site_name} - Confirm your new account")
    |> render_body("confirmation.html", %{url: url, name: first_name(user.name)})
  end

  def invitation(invitation, url) do
    %Email{}
    |> from(from_email)
    |> to(user_email(invitation))
    |> add_reply_to
    |> subject("#{site_name} - Invitation to create a new account")
    |> render_body("invitation.html", %{url: url, name: first_name(invitation.name)})
  end

  def unlock(user, url) do
    %Email{}
    |> from(from_email)
    |> to(user_email(user))
    |> add_reply_to
    |> subject("#{site_name} - Unlock Instructions")
    |> render_body("unlock.html", %{url: url, name: first_name(user.name)})
  end

  defp add_reply_to(mail) do
    case Coherence.Config.email_reply_to do
      nil              -> mail
      true             -> reply_to mail, from_email
      address          -> reply_to mail, address
    end
  end

  defp first_name(name) do
    case String.split(name, " ") do
      [first_name | _] -> first_name
      _ -> name
    end
  end

  defp user_email(user) do
    {user.name, user.email}
  end

  defp from_email do
    case Coherence.Config.email_from do
      nil ->
        Logger.error ~s|Need to configure :coherence, :email_from_name, "Name", and :email_from_email, "me@example.com"|
        nil
      {name, email} = email_tuple ->
        if is_nil(name) or is_nil(email) do
          Logger.error ~s|Need to configure :coherence, :email_from_name, "Name", and :email_from_email, "me@example.com"|
          nil
        else
          email_tuple
        end
    end
  end
end
