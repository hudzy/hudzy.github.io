---
layout: post
title: "Mouse Movement Script"
date: 2024-07-21
tags: [折腾]
---

# Mouse Movement Automation and Tracking Script

## Introduction

This script is designed to automate mouse movements and track user mouse activity. It offers two modes of cursor movement: random and one-pixel. Additionally, it logs the time of the last mouse movement to avoid redundant automated movements and provides the flexibility to control whether the Ctrl key is pressed during automated movements.

## Features

- **Cursor Movement Modes**:

  - **Random Movement**: Moves the cursor to random locations on the screen smoothly over a specified duration.
  - **One-Pixel Movement**: Moves the cursor by one pixel in a random direction (left, right, up, or down).

- **Mouse Movement Tracking**:

  - Tracks and logs the time of the last mouse movement to avoid triggering automated movements if the cursor has been moved recently.

- **Logging**:

  - Provides detailed logs of cursor movements and actions, including timestamps and coordinates.

- **Customizable Parameters**:
  - **Movement Mode**: Choose between random or one-pixel movement.
  - **Movement Interval**: Set the interval in seconds between automated movements.
  - **Movement Duration**: Define the duration over which the cursor moves smoothly (only applicable for random mode).
  - **Runtime Duration**: Specify how long the script should run before stopping.
  - **Skip Interval**: Set the time interval to skip movements if the cursor has been moved recently.
  - **Ctrl Key Press**: Optionally press the Ctrl key during automated movements.

## Installation

Ensure you have Python installed, and then install the required packages using `pip`:

```bash
pip install pyautogui pynput
```

## Usage

1. **Run the Script**:

   Execute the script using Python:

   ```bash
   python mouse_movement_script.py
   ```

2. **Configure the Script**:

   Follow the on-screen prompts to configure the script settings:

   - **Mode**: Choose between `random` or `one_pixel`.
   - **Interval**: Enter the interval in seconds between cursor movements (default is 30).
   - **Duration**: Enter the duration in seconds for cursor movement (default is 1, applicable to random mode).
   - **Runtime**: Enter the total runtime in minutes (default is 30).
   - **Skip Interval**: Enter the time interval in seconds for skipping movements (default is 120).
   - **Ctrl Key Press**: Enable or disable Ctrl key press during movements (default is enabled).

3. **Stop the Script**:

   To stop the script, you can manually interrupt it by pressing `Ctrl+C` in the terminal.

## Example

```bash
python mouse_movement_script.py
```

_Enter the mode (random/r, one_pixel/o, default is one_pixel):_ `random`

_Enter the interval in seconds between cursor movements (default is 30):_ `60`

_Enter the duration in seconds for cursor movement (default is 1):_ `2`

_Enter the total runtime in minutes (default is 30):_ `10`

_Enter the time interval in seconds for skipping movements (default is 120):_ `60`

_Enable Ctrl key press during movements? (yes/y or no/n, default is yes):_ `no`

The script will start running in random mode, moving the cursor to random locations every 60 seconds, for a total runtime of 10 minutes. It will skip movements if the cursor has been moved within the last 60 seconds and will not press the Ctrl key during movements.

## License

This script is provided under the MIT License.

---

# 鼠标移动自动化和跟踪脚本

## 介绍

此脚本旨在自动化鼠标移动并跟踪用户的鼠标活动。它提供两种光标移动模式：随机移动和单像素移动。此外，它会记录最后一次鼠标移动的时间，以避免在鼠标最近被移动的情况下触发冗余的自动化移动，并提供是否在自动化移动过程中按下 Ctrl 键的选项。

## 特性

- **光标移动模式**：

  - **随机移动**：将光标平滑地移动到屏幕上的随机位置，移动过程持续指定的时间。
  - **单像素移动**：将光标在随机方向（左、右、上或下）上移动一个像素。

- **鼠标移动跟踪**：

  - 跟踪并记录最后一次鼠标移动的时间，以避免在鼠标最近被移动的情况下触发自动化移动。

- **日志记录**：

  - 提供光标移动和操作的详细日志，包括时间戳和坐标。

- **可定制参数**：
  - **移动模式**：选择 `random`（随机）或 `one_pixel`（单像素）模式。
  - **移动间隔**：设置自动化移动之间的时间间隔（默认为 30 秒）。
  - **移动持续时间**：定义光标平滑移动的持续时间（仅适用于随机模式）。
  - **运行时间**：指定脚本应运行的总时间（以分钟为单位）。
  - **跳过间隔**：设置在鼠标最近被移动的情况下跳过移动的时间间隔。
  - **Ctrl 键按下**：在自动化移动过程中选择是否按下 Ctrl 键。

## 安装

确保安装了 Python，然后使用 `pip` 安装所需的包：

```bash
pip install pyautogui pynput
```

## 使用

1. **运行脚本**：

   使用 Python 执行脚本：

   ```bash
   python mouse_movement_script.py
   ```

2. **配置脚本**：

   按屏幕上的提示配置脚本设置：

   - **模式**：选择 `random`（随机）或 `one_pixel`（单像素）。
   - **间隔**：输入光标移动之间的时间间隔（默认为 30 秒）。
   - **持续时间**：输入光标移动的持续时间（默认为 1 秒，仅适用于随机模式）。
   - **运行时间**：输入脚本的总运行时间（默认为 30 分钟）。
   - **跳过间隔**：输入在鼠标最近被移动的情况下跳过移动的时间间隔（默认为 120 秒）。
   - **Ctrl 键按下**：选择是否在移动过程中按下 Ctrl 键（默认为启用）。

3. **停止脚本**：

   要停止脚本，可以通过在终端中按 `Ctrl+C` 手动中断它。

## 示例

```bash
python mouse_movement_script.py
```

_输入模式（random/r, one_pixel/o，默认为 one_pixel）：_ `random`

_输入光标移动之间的时间间隔（默认为 30 秒）：_ `60`

_输入光标移动的持续时间（默认为 1 秒）：_ `2`

_输入脚本的总运行时间（默认为 30 分钟）：_ `10`

_输入在鼠标最近被移动的情况下跳过移动的时间间隔（默认为 120 秒）：_ `60`

_是否在移动过程中按下 Ctrl 键？（yes/y 或 no/n，默认为 yes）：_ `no`

脚本将以随机模式开始运行，每 60 秒将光标移动到随机位置，总运行时间为 10 分钟。如果鼠标在过去 60 秒内已被移动，则将跳过移动，并且在移动过程中不会按下 Ctrl 键。

## 许可证

此脚本根据 MIT 许可证提供。

---

## The Code

Here is the full script:

以下是完整的脚本：

```python
import logging
import random
import time

import pyautogui
from pynput import mouse

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(message)s")

# Global variable to store the last mouse move time
last_move_time = None

# Define the interval for skipping movement, default to 120 seconds
SKIP_INTERVAL = 120


def on_move(x, y):
    global last_move_time
    last_move_time = time.time()
    #  logging.info(f"Mouse moved to ({x}, {y}) at {time.ctime(last_move_time)}")


def move_cursor_randomly(duration, press_ctrl):
    global last_move_time

    # Get the screen size
    screen_width, screen_height = pyautogui.size()

    # Check if the cursor was moved recently
    current_time = time.time()
    if last_move_time and (current_time - last_move_time < SKIP_INTERVAL):
        logging.info("Cursor was moved recently. Skipping movement.")
        return

    # Generate random coordinates
    x = random.randint(0, screen_width - 1)
    y = random.randint(0, screen_height - 1)

    # Move the mouse to the random coordinates smoothly
    pyautogui.moveTo(x, y, duration=duration)

    # Press a keyboard key if enabled
    if press_ctrl:
        pyautogui.press("ctrl")
        logging.info(
            f'Moved cursor to ({x}, {y}) smoothly over {duration} seconds and pressed "ctrl"'
        )
    else:
        logging.info(f"Moved cursor to ({x}, {y}) smoothly over {duration} seconds")

    # Update the last move time
    last_move_time = current_time


def move_cursor_one_pixel(press_ctrl):
    global last_move_time

    # Get the current mouse position
    x, y = pyautogui.position()

    # Check if the cursor was moved recently
    current_time = time.time()
    if last_move_time and (current_time - last_move_time < SKIP_INTERVAL):
        logging.info("Cursor was moved recently. Skipping movement.")
        return

    # Determine the direction to move: left, right, up, or down
    direction = random.choice(["left", "right", "up", "down"])

    if direction == "left":
        x_offset, y_offset = -1, 0
    elif direction == "right":
        x_offset, y_offset = 1, 0
    elif direction == "up":
        x_offset, y_offset = 0, -1
    else:  # direction == 'down'
        x_offset, y_offset = 0, 1

    # Move the mouse 1 pixel in the chosen direction
    pyautogui.move(x_offset, y_offset)

    # Press a keyboard key if enabled
    if press_ctrl:
        pyautogui.press("ctrl")
        logging.info(
            f'Moved cursor 1 pixel to the {direction} to ({x + x_offset}, {y + y_offset}) and pressed "ctrl"'
        )
    else:
        logging.info(
            f"Moved cursor 1 pixel to the {direction} to ({x + x_offset}, {y + y_offset})"
        )

    # Update the last move time
    last_move_time = current_time


def main(mode, interval, duration, runtime_minutes, press_ctrl):
    start_time = time.time()
    try:
        while True:
            if mode == "random":
                move_cursor_randomly(duration, press_ctrl)
            elif mode == "one_pixel":
                move_cursor_one_pixel(press_ctrl)

            time.sleep(interval)
            elapsed_time = (time.time() - start_time) / 60  # convert to minutes
            if elapsed_time >= runtime_minutes:
                logging.info(f"Script has run for {runtime_minutes} minutes. Exiting.")
                break
    except KeyboardInterrupt:
        logging.info("Program terminated by user")


if __name__ == "__main__":
    # Setup the mouse listener
    mouse_listener = mouse.Listener(on_move=on_move)

    # Start the listener
    mouse_listener.start()

    print("Listening for mouse movements.")

    # User-defined mode with shorthand options
    mode_input = (
        input("Enter the mode (random/r, one_pixel/o, default is one_pixel): ")
        .strip()
        .lower()
    )
    if mode_input in ["random", "r"]:
        mode = "random"
    elif mode_input in ["one_pixel", "o"]:
        mode = "one_pixel"
    else:
        mode = "one_pixel"

    # User-defined interval
    interval = input(
        "Enter the interval in seconds between cursor movements (default is 30): "
    )
    try:
        interval = float(interval)
    except ValueError:
        interval = 30

    # User-defined duration (only used in 'random' mode)
    duration = input(
        "Enter the duration in seconds for cursor movement (default is 1): "
    )
    try:
        duration = float(duration)
    except ValueError:
        duration = 1

    # User-defined runtime duration
    runtime_minutes = input("Enter the total runtime in minutes (default is 30): ")
    try:
        runtime_minutes = float(runtime_minutes)
    except ValueError:
        runtime_minutes = 30

    # User-defined SKIP_INTERVAL
    skip_interval_input = input(
        "Enter the time interval in seconds for skipping movements (default is 120): "
    )
    try:
        SKIP_INTERVAL = int(skip_interval_input)
    except ValueError:
        SKIP_INTERVAL = 120

    # User-defined control for keyboard press
    press_ctrl_input = (
        input(
            "Enable Ctrl key press during movements? (yes/y or no/n, default is yes): "
        )
        .strip()
        .lower()
    )
    press_ctrl = press_ctrl_input not in ["no", "n"]

    logging.info(
        f'Starting cursor movement in {mode} mode with {interval} seconds interval, {duration} seconds duration for each movement (if applicable), a total runtime of {runtime_minutes} minutes, skipping movements if cursor was moved in the last {SKIP_INTERVAL} seconds, and {"enabling" if press_ctrl else "disabling"} Ctrl key press during movements'
    )
    main(mode, interval, duration, runtime_minutes, press_ctrl)

    # Ensure the listener is properly stopped
    mouse_listener.stop()
```
