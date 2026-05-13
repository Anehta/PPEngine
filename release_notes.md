## 📦 PPEngine v1.9.8

Major update for **PPEngine** — professional model review tool for shipbuilding, marine engineering, and plant design. See the [README](https://github.com/Anehta/PPEngine) for the full feature list.

### 📥 Downloads

| Archive | Description |
| :-- | :-- |
| 🎨 `PPEngineV1.9.8.7z` | PPEngine viewer (main application) |
| 📖 `PPEngineUserManual.7z` | Full operation manual (English + 简体中文) |
| 🧲 `PPAMExtractor.7z` | AM data extraction plugin |
| 🛳️ `PPM3Exporter.7z` | Tribon M3 data extraction plugin |

### 🗂️ Supported Formats

`REV` · `RVM` · `STEP` · `VUE` · `3D Gaussian Splatting`

### 🌍 Platforms

Windows · Linux · Android · iOS · Web · OpenXR (VR / AR)

---

### 🌟 What's New in v1.9.8

#### ★ Headline — SmartPlant 3D `.vue` Native Support + PP3D Core Geometry Kernel

- **Direct import of SmartPlant 3D `.vue` files** — in-house parser, **no conversion layer**, rendered in real time through the PP3D Core geometry kernel. A recent update also enables **direct loading in the Web build** — plant-scale PLM libraries now run inside a browser.
- **PP3D Core, our in-house geometry kernel, is now formally part of PPEngine.** All geometry / B-Rep parsing and construction is first-party, with **zero external geometry-kernel dependencies**. Lays the foundation for future real-time editing and parametric modeling.

#### 🎯 Full-Fidelity Rendering at Every Distance

Tiered LOD is gone — **full-fidelity meshes run at any distance**, details are always there.

- Camera turns in big scenes no longer drop details or pop in geometry; the frame stays clean.
- Selected or highlighted components are **never culled** — visible no matter how small or occluded.
- The Web build shares the same rendering path as Desktop, keeping the in-browser experience native-grade.

#### 🖱️ Multi-Select & Box-Select — Professional Selection Workflow

- **<kbd>Shift</kbd> + Left-Click** — additive multi-select; the Component Browser and 3D viewport sync both ways in real time.
- **<kbd>Ctrl</kbd> + Drag** — rectangle box-select. AutoCAD-style Window / Crossing modes; components inside the rect are selected **even when occluded**. <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + Drag = additive box-select.
- **Right-click in the 3D viewport** opens a context menu acting on the current selection:
  - **Isolate** — dims everything outside the selection, focus on it.
  - **Clip to Selection** — builds a clipping box from the selection's bounds.
  - **Show All** — restores original colors and clears clipping.

#### ⚡ Performance & Fidelity Fixes

- **Browser highlight no longer drops frames at tens-of-thousands selections** (60 K-component case now stays at full frame rate).
- **High-ID components are fully pickable** — fixed a residual cap that silently made 93% of components in large models invisible to picking.
- **RVM conversion is 2-3× faster** (single-file path).
- **HULL_TUGBOAT-style all-black RVM models** — fixed the default-color-#1 problem that rendered some models fully black.
- **Measurements & markers** auto-hide during explosion to avoid visually detaching from displaced components; reappear in place when explosion returns to zero.

---

### ✨ Carryover Highlights

- 🚀 **GPU-first pipeline** — picking · culling · GPU-driven indirect draw
- 🛰️ **Ultra-low-latency remote streaming** — cloud-gaming-style, headless server, multi-client 1080p @ 60 fps
- 🌐 **Full cross-platform** — same engine / same scene everywhere, including browser
- 🕶️ **Native OpenXR** — step inside your model for immersive design review
- 🗂️ **`.ppws` workspace** — persist camera, measurements, markers, clipping state; pack & share as `.ppz`

### 📬 Contact

- 🆓 Free model conversion server software: **devin@pathplus.cn**
- 💼 Customized development & business inquiries: **shanghai@pathplus.cn**
- 🌐 [www.pathplus.cn](https://www.pathplus.cn) — **上海蹊加科技有限公司 · Shanghai PathPlus Technology Co., Ltd.**
