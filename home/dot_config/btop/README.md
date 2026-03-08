# btop Configuration

btop is an interactive terminal system monitor (CPU, memory, disks, network, processes).

- Project: https://github.com/aristocratos/btop
- Source: `home/dot_config/btop/btop.conf`
- Target: `~/.config/btop/btop.conf`

## What This Config Controls

- Theme/rendering: `color_theme`, `truecolor`, `rounded_corners`, `graph_symbol*`.
- Panel layout: `shown_boxes`, `presets`, `proc_left`, `cpu_bottom`, `status options`.
- Sampling behavior: `update_ms`, network autoscaling, disk IO graph settings.
- Process list behavior: sorting mode, tree mode, per-core views, gradients.
- Hardware metrics: temperatures, battery display, disk filters, swap visibility.

## Key Current Choices In This Repo

- `shown_boxes = "cpu mem net proc"`: focused default dashboard.
- `update_ms = 2000`: lower noise and lower overhead than very fast refresh rates.
- `check_temp = True` and `show_coretemp = True`: thermal visibility enabled.
- `show_disks = True`, `show_io_stat = True`: disk activity is visible by default.
- `net_auto = True`: network scale auto-adjusts to current traffic.

## Editing Workflow

- btop writes this file when settings are changed in the UI.
- If you tune from inside btop, review the resulting diff before committing.
- Keep only stable preference changes; avoid machine-specific transient values.
