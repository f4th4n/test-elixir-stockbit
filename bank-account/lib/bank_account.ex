defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def init(_) do
    {:ok, 0}
  end

  def handle_call(:balance, _, balance), do: {:reply, balance, balance}
  def handle_cast({:update, amount}, state), do: {:noreply, state + amount}

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start(__MODULE__, nil)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    cond do
      !Process.alive? account -> {:error, :account_closed}
      true -> GenServer.call(account, :balance)
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    cond do
      !Process.alive? account -> {:error, :account_closed}
      true -> GenServer.cast(account, {:update, amount})
    end
  end
end
