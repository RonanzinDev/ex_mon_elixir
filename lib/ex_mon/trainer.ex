defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string

    # esse campo nao ira para o banco, e usuario ira apenas digitar para depois incriptarmos a senha
    field :password, :string, virtual: true
    timestamps()
  end

  @required_params [:name, :password]

  def build(params) do
    params |> changeset() |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  # fazendo pattern matching para ver se o valid? é igual a true
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{passsword: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
