---
layout: post
title: "Cursor Movement Script"
date: 2024-07-21
tags: [折腾]
---

# Blog Post: Automating Cursor Movement to Prevent System Idle

## English Version

---

### Automating Cursor Movement to Prevent System Idle

Have you ever faced the frustration of your computer going idle during important tasks? Whether you're running long processes, downloading large files, or simply want to keep your system awake, our Python script provides a reliable solution to prevent your computer from going idle. This script automates cursor movement with various configurable options to suit your needs.

### Features

**1. Two Modes of Cursor Movement:**

- **Random Movement (random or r):** Moves the cursor to random coordinates on the screen smoothly over a specified duration.
- **One Pixel Movement (one_pixel or o):** Moves the cursor one pixel in a random direction (left, right, up, or down).

**2. Configurable Intervals:**

- Set the interval in seconds between each cursor movement.

**3. Duration Setting:**

- For random movement mode, set the duration in seconds for each movement.

**4. Total Runtime:**

- Specify the total runtime in minutes for which the script will run.

**5. Skip Movement Feature:**

- If the cursor has been moved within the last specified number of seconds, the script will skip the movement. This interval is configurable.

**6. Keyboard Press Toggle:**

- Option to enable or disable pressing the 'Ctrl' key during cursor movements.

### Usage Instructions

1. **Download and Install Requirements:**

   Ensure you have Python installed on your system. Install the required module using:

   ```sh
   pip install pyautogui
   ```

2. **Run the Script:**

   Save the script provided below into a file, for example, `cursor_mover.py`, and run it using:

   ```sh
   python cursor_mover.py
   ```

3. **Input Configuration:**

   - **Mode:** Choose between random (r) or one_pixel (o).
   - **Interval:** Set the interval in seconds between cursor movements (default is 30).
   - **Duration:** Set the duration in seconds for each movement in random mode (default is 1).
   - **Total Runtime:** Specify the total runtime in minutes (default is 30).
   - **Skip Interval:** Enter the time interval in seconds for skipping movements (default is 120).
   - **Keyboard Press:** Enable or disable 'Ctrl' key press during movements (default is yes).

---

## Chinese Version

---

### 自动化光标移动以防止系统闲置

你是否曾经因为在执行重要任务时，计算机进入闲置状态而感到沮丧？无论你是在运行长时间进程、下载大文件，还是只是想保持系统唤醒，我们的Python脚本都能为你提供可靠的解决方案，防止你的计算机进入闲置状态。这个脚本通过多种可配置选项自动化光标移动，以满足你的需求。

### 功能

**1. 两种光标移动模式：**

- **随机移动（random 或 r）：** 将光标平滑地移动到屏幕上的随机坐标，持续指定的时间。
- **单像素移动（one_pixel 或 o）：** 将光标随机向一个方向（左、右、上或下）移动一个像素。

**2. 可配置间隔：**

- 设置每次光标移动之间的秒数间隔。

**3. 持续时间设置：**

- 对于随机移动模式，设置每次移动的秒数。

**4. 总运行时间：**

- 指定脚本运行的总时间（分钟）。

**5. 跳过移动功能：**

- 如果在指定的秒数内光标已被移动，则跳过这次移动。此间隔可配置。

**6. 键盘按键切换：**

- 选择在

光标移动期间是否按下“Ctrl”键。

### 使用说明

1. **下载并安装依赖：**

   确保你的系统上已安装Python。使用以下命令安装所需模块：

   ```sh
   pip install pyautogui
   ```

2. **运行脚本：**

   将以下脚本保存到文件（如 `cursor_mover.py`），然后使用以下命令运行：

   ```sh
   python cursor_mover.py
   ```

3. **输入配置：**

   - **模式:** 选择 random（r）或 one_pixel（o）。
   - **间隔:** 设置每次光标移动之间的秒数间隔（默认30）。
   - **持续时间:** 在随机移动模式下设置每次移动的秒数（默认1）。
   - **总运行时间:** 指定总运行时间（分钟，默认30）。
   - **跳过间隔:** 输入跳过移动的时间间隔（秒，默认120）。
   - **键盘按键:** 选择是否在移动期间按下“Ctrl”键（默认是）。

---

## The Code

Here is the full script:

以下是完整的脚本：

```python
import logging
import random
import time

import pyautogui

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(message)s")

# Define the interval for skipping movement, default to 120 seconds
SKIP_INTERVAL = 120

last_move_time = None


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
```
