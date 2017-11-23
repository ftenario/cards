defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a a list of string representing a deck of cards
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six","Seven", "Eight", "Nine", "Ten", "Jack", "Queen","King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    #solution 1
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)

      for suit <- suits, value <- values do
        "#{value} of #{suit}"
      end
  end

  def shuffle(deck) do
    deck
    |> Enum.shuffle
  end

  @doc """
    Determines wether a deck contains a given card

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true

  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand
  
    ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck,1)
        iex> hand
        ["Ace of Spades"]

    """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  #Version 1 for load
  # def load(filename) do{}
  #   {status, binary} = File.read(filename)

  #   case status do
  #     :ok -> :erlang.binary_to_term binary
  #     :error -> "That file does not exists"
  #   end
  
  # end

  def load(filename) do

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exists"
    end
  
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
