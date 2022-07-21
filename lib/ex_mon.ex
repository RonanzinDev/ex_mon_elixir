defmodule ExMon do
  alias ExMon.Trainer
  # quando chamarmos ExMon.create_trainer(), vai ser a mesma coisa que chamar
  # ExMon.Trainer.Create.call(), é só um renomeamento
  defdelegate create_trainer(params), to: Trainer.Create, as: :call
end
