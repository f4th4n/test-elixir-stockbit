defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  defstruct direction: :north, position: {0, 0}

  defguard is_valid?(direction) when direction in [:north, :south, :east, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create() do
    %RobotSimulator{}
  end

  def create(direction, position = {x, y})
      when is_valid?(direction) and is_integer(x) and is_integer(y) do
    %RobotSimulator{direction: direction, position: position}
  end

  def create(_, _position = {x, y}) when is_integer(x) and is_integer(y) do
    {:error, "invalid direction"}
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    instruction_list = String.graphemes(instructions)

    contain_invalid_instruction? =
      Enum.map(instruction_list, fn v -> !Enum.member?(["L", "R", "A"], v) end) |> Enum.any?()

    if contain_invalid_instruction? do
      {:error, "invalid instruction"}
    else
      move_robot(robot, instruction_list)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end

  def move_robot(robot = %RobotSimulator{direction: :north, position: _}, [h | t])
      when h == "L" do
    %{robot | direction: :west} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :west, position: _}, [h | t]) when h == "L" do
    %{robot | direction: :south} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :south, position: _}, [h | t])
      when h == "L" do
    %{robot | direction: :east} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :east, position: _}, [h | t]) when h == "L" do
    %{robot | direction: :north} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :north, position: _}, [h | t])
      when h == "R" do
    %{robot | direction: :east} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :east, position: _}, [h | t]) when h == "R" do
    %{robot | direction: :south} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :south, position: _}, [h | t])
      when h == "R" do
    %{robot | direction: :west} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :west, position: _}, [h | t]) when h == "R" do
    %{robot | direction: :north} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :north, position: {x, y}}, [h | t])
      when h == "A" do
    %{robot | position: {x, y + 1}} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :west, position: {x, y}}, [h | t])
      when h == "A" do
    %{robot | position: {x - 1, y}} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :east, position: {x, y}}, [h | t])
      when h == "A" do
    %{robot | position: {x + 1, y}} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :east, position: {x, y}}, [h | t])
      when h == "A" do
    %{robot | position: {x + 1, y}} |> move_robot(t)
  end

  def move_robot(robot = %RobotSimulator{direction: :south, position: {x, y}}, [h | t])
      when h == "A" do
    %{robot | position: {x, y - 1}} |> move_robot(t)
  end

  def move_robot(robot, [h | _] = l) when is_list(l) and is_valid?(h) do
    move_robot(robot, [h])
  end

  def move_robot(robot, _) do
    robot
  end
end
