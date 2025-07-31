

## 🧠 Mod Key

The `$mod` key is set to `Mod1` (usually **Alt**).
You can change this in your config by editing:

```i3
set $mod Mod1
```

---

## 🖥 Window Management

| Shortcut                 | Action                              |
| ------------------------ | ----------------------------------- |
| `$mod + j`               | Focus left                          |
| `$mod + k`               | Focus down                          |
| `$mod + l`               | Focus up                            |
| `$mod + ;`               | Focus right                         |
| `$mod + ←/↓/↑/→`         | Focus in respective direction       |
| `$mod + Shift + j`       | Move window left                    |
| `$mod + Shift + k`       | Move window down                    |
| `$mod + Shift + l`       | Move window up                      |
| `$mod + Shift + ;`       | Move window right                   |
| `$mod + Shift + ←/↓/↑/→` | Move window in respective direction |

---

## 🔳 Layout Control

| Shortcut               | Action                 |
| ---------------------- | ---------------------- |
| `$mod + h`             | Split horizontally     |
| `$mod + v`             | Split vertically       |
| `$mod + f`             | Toggle fullscreen      |
| `$mod + w`             | Use tabbed layout      |
| `$mod + s`             | Toggle split layout    |
| `$mod + Shift + space` | Toggle floating mode   |
| `$mod + Shift + t`     | Toggle focus mode      |
| `$mod + a`             | Focus parent container |

---

## 📐 Resize Mode

| Shortcut (in resize mode)    | Action           |
| ---------------------------- | ---------------- |
| `j / ←`                      | Shrink width     |
| `k / ↓`                      | Grow height      |
| `l / ↑`                      | Shrink height    |
| `; / →`                      | Grow width       |
| `Return / Escape / $mod + r` | Exit resize mode |

Enter resize mode with:

```bash
$mod + r
```

---

## 🗂 Workspace Navigation

| Shortcut               | Action                        |
| ---------------------- | ----------------------------- |
| `$mod + [1-0]`         | Switch to workspace 1–10      |
| `$mod + Shift + [1-0]` | Move window to workspace 1–10 |

---

## 📦 Application Launch

| Shortcut       | Action                             |
| -------------- | ---------------------------------- |
| `$mod + Enter` | Launch terminal (`xfce4-terminal`) |
| `$mod + e`     | Launch file manager (`thunar`)     |
| `$mod + space` | Launch app launcher (`rofi`)       |
| `$mod + q`     | Kill focused window                |

---

## 🎵 Media Controls (via `mpc` + MPD)

| Shortcut           | Action            |
| ------------------ | ----------------- |
| `$mod + Shift + p` | Play / Pause      |
| `$mod + Shift + n` | Next track        |
| `$mod + Shift + b` | Previous track    |
| `$mod + Shift + s` | Stop playback     |
| `$mod + Shift + i` | Show current song |

> ⚠️ Make sure `mpc` and `mpd` are installed and configured.

---

## 🔁 Session Control

| Shortcut           | Action             |
| ------------------ | -------------      |
| `$mod + Shift + z` | Reload config      |
| `$mod + Shift + r` | Restart i3         |

---
