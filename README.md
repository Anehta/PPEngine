<div align="center">

<img src="capture/logo.png" width="160" alt="PPEngine logo" />

# ✦ PPEngine ✦

### 🚢 Professional Model Review Tool &nbsp;+&nbsp; 🧠 PP3D Graphics Kernel

*Built for **shipbuilding · marine engineering · plant design** — cross-platform · high-performance · production-proven*

**Supported formats:** &nbsp;`REV` &nbsp;·&nbsp; `RVM` &nbsp;·&nbsp; `STEP` &nbsp;·&nbsp; `3D Gaussian Splatting`

<br/>

**🌐 Language:** &nbsp; **English** &nbsp;·&nbsp; [简体中文](README.zh-CN.md)

<br/>

![Version](https://img.shields.io/badge/version-1.8.5-blue?style=flat-square)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20Web%20%7C%20Android%20%7C%20VR%2FAR-lightgrey?style=flat-square)
![License](https://img.shields.io/badge/license-Free-green?style=flat-square)
![Model Size](https://img.shields.io/badge/10GB%20model-~5s%20load-orange?style=flat-square)
![FPS](https://img.shields.io/badge/rendering-~60fps-success?style=flat-square)

<br/>

[🎬 Overview](#-1-overview) •
[🖼️ Gallery](#-2-global-ship-view) •
[📐 Measurement](#-3-measurement--inspection) •
[🕶️ XR / VR](#-4-xr--vr-design-review) •
[✦ 3DGS](#-5-3d-gaussian-splatting) •
[🗂️ Workspace](#-6-workspace-management) •
[🔌 Extractors](#-7-extraction-plugins) •
[📖 Manual](#-8-operation-manual) •
[📬 Contact](#-9-contact)

<br/>

### 📥 Download

**All binaries — the viewer, the AM extractor, the Tribon M3 extractor, and the operation manual — are available on the [GitHub Releases page](../../releases).**

Grab the `.7z` archives below and you're ready to go:

| 📦 Archive | 📝 Contents |
| :-- | :-- |
| 🎨 `PPEngineV1.8.5.7z` | PPEngine viewer **+ operation manual** |
| 🧲 `PPAMExtractor.7z` | AM extraction plugin |
| 🛳️ `PPM3Exporter.7z` | Tribon M3 extraction plugin |

</div>

---

## 🎬 1. Overview

PPEngine is actually **two things shipped together**:

| | Product | What it is |
| :-- | :-- | :-- |
| 🚢 | **PPEngine** — *Professional Model Review Tool* | A free, focused desktop + web application for lightweight conversion, viewing, digital delivery, and **design review** of large-scale industrial models. Currently ingests **`REV` · `RVM` · `STEP` · `3D Gaussian Splatting`**. Purpose-built for **shipbuilding, marine engineering, and plant design**. |
| 🧠 | **PP3D Core** — *Graphics Kernel* | The self-developed cross-platform graphics kernel underneath PPEngine. A licensable engine/SDK layer you can embed and extend — comprehensive APIs, customizable on demand. |

> In short: **PPEngine is the product you use today. PP3D Core is the engine you can build on tomorrow.**

> 🛠️ **Built from the graphics layer up — no black boxes.**
> PP3D Core is **re-implemented from scratch at the graphics-API level** — every render pass, every buffer layout, every GPU dispatch is our own code. No third-party game engine, no retrofitted CAD kernel. This is why we can squeeze performance that off-the-shelf viewers simply can't reach, and why we can customize *any* pipeline stage on demand.

> 🌍 **True cross-platform — one engine, every device.**
> **Native PC (Windows) · Linux · Android · iOS · Web** — the same engine, the same scene, the same feature set.
> 🎮 **Modern graphics APIs everywhere:** native platforms run on **DX12 / Vulkan**; the Web build runs on **WebGPU**; and **OpenXR** rendering is supported first-class for immersive VR / AR design review — no legacy code paths, no lowest-common-denominator compromises. *(WebGL fallback available on request — [contact us](#-9-contact).)*
> The Web build is particularly wild: we **bypass the browser's V8 memory ceiling** with an engine-level memory architecture, so a **full-ship 10 GB-class model loads and renders in the browser** — something conventional WebGL viewers hit a wall on long before they get close.

> 📦 **Open SDK — 🚧 in active development.**
> A public SDK for PP3D Core is on the way — embed the engine in your own apps, extend pipelines, script business logic, and ship custom viewers on any supported platform. [Get in touch](#-9-contact) if you'd like early access or want to shape the API surface.

PPEngine is commonly used to extract model and attribute information from **Tribon / AM / SPD / CATIA**, and to generate lightweight models in real-time via a dedicated conversion server. Users can quickly view, annotate, and record on-site.

### ⚡ Performance at a glance

| Metric                     | Result                             |
| :------------------------- | :--------------------------------- |
| 📦 Source model size        | **~10 GB** REV / RVM              |
| ⏱️ Lightweight load time    | **~5 seconds** (mid-range PC)     |
| 🎞️ Display frame rate       | **~60 fps**                       |
| 🌐 Platforms                | Windows · Linux · Web · Android · VR/AR |

> 💡 **Tip** — Contact us to get the free **Tribon / AM** server extractor so your team can explore lightweight models in real time without paying conversion overhead.

### 🚀 Ultra-Optimized GPU Pipeline

> Every rendering stage of PP3D Core is built **GPU-first** — the CPU only schedules work; the GPU does the heavy lifting. That's how we push **10 GB-class models at 60 fps** on mid-range hardware.

| 🔥 Feature | 💬 What it buys you |
| :-- | :-- |
| 🎯 **GPU Picking** | Pixel-perfect object selection fully on the GPU — zero CPU raycasts, constant-time regardless of scene complexity |
| ✂️ **GPU Frustum Culling** | Per-instance visibility computed on the GPU every frame — invisible geometry never touches the rasterizer |
| 🫥 **GPU Occlusion Culling** | Hierarchical depth-buffer occlusion queries on-GPU — parts hidden behind the hull, bulkheads, or dense equipment are skipped entirely, even when inside the frustum |
| 📦 **GPU-Driven Indirect Draw** | Draw calls are authored on the GPU itself, collapsing **millions of parts** into a handful of `DrawIndirect` dispatches |
| 🛰️ **Ultra-Low-Latency Remote Streaming** | Cloud-gaming-style pixel streaming — run the engine **headless** on a beefy server and stream rendered frames to any thin client (laptop · tablet · phone · browser). Delivers **multi-client 1080p @ 60 fps** concurrently with latency so low the experience is **virtually indistinguishable from running locally**. The 10 GB model lives on the server; the client only receives pixels + sends input |
| 📐 **Automatic LOD & Streaming** | Per-batch LOD switching + queued async loading — near parts stay crisp, far parts stay cheap, nothing blocks the frame |
| 🧮 **GPU-side Transform Sync** | Object transforms live on the GPU; hierarchy updates avoid the CPU↔GPU round-trip entirely |
| 💡 **Screen-Space Ambient Occlusion** | High-quality SSAO baked into the pipeline for free depth cues in complex piping / machinery views |
| 🖥️ **Adaptive Resolution Scaling** | Dynamic internal-resolution scaling — keeps interactivity smooth while panning / orbiting huge models |
| ✦ **3D Gaussian Splatting** | Native support for photo-real captured scenes alongside traditional meshes |
| 📏 **Precision Clipping & Measurement** *(BRep mode 🚧 WIP)* | GPU-accelerated clipping boxes + high-precision measurement overlays, stable at extreme camera ranges. **Upcoming:** resolving measurements directly against the **original BRep** data (not the display mesh) — not fully rolled out in this release, currently under active development |

> ⚙️ **The payoff** — a single engineer's laptop can review an entire vessel that used to require a workstation. No pre-baking, no scene simplification, no "please wait" dialogs.

### 🧩 PP3D Core

A cross-platform high-performance display library with comprehensive APIs and customizable development on demand:

- 🏗️ **MBSE integration** for ship construction processes
- 🔧 **Equipment & parts** information management
- 📊 **Production** information visualization
- ✏️ **3D drawing** applications
- 💥 **Collision / clash** check
- 🎯 **Model filtering** for specific business scenarios
- ⚙️ **Weld line** recognition
- 🎨 **Paint area** recognition
- ✅ **On-site quality** inspection
- 🕶️ **XR application** development

---

## 🖼️ 2. Global Ship View

> Full-vessel lightweight rendering — tens of millions of triangles, loaded in seconds.

<div align="center">

<img src="capture/ship.png"  alt="Full ship overview"      width="88%" />

<br/><br/>

<img src="capture/ship2.png" alt="Full ship alternate view" width="88%" />

</div>

---

## 📐 3. Measurement & Inspection

> Interactive tools for **distance · angle · clearance · dimensional** review, accurate down to the millimetre.

<div align="center">

<img src="capture/measure.png"  alt="Measurement — linear"  width="88%" />

<br/><br/>

<img src="capture/measure2.png" alt="Measurement — clearance" width="88%" />

</div>

---

## 🕶️ 4. XR / VR Design Review

> First-class **OpenXR** rendering — step inside your model, walk the decks, inspect machinery 1:1, and run immersive design reviews with collaborators on headsets.

<div align="center">

<img src="capture/XR.png"  alt="Immersive XR review"       width="88%" />

<br/><br/>

<img src="capture/XR2.png" alt="XR inspection close-up"    width="88%" />

</div>

**✨ What you get in XR:**

- 🥽 **Native OpenXR** — works with any compliant headset (Quest, Vive, Pico, Varjo, Index, …)
- 🚶 **1:1 walk-through** of full-ship / full-plant models at production scale
- 🤝 **Collaborative review** — multiple reviewers sharing the same scene
- 📏 **Measurement & markup in-headset** — annotate exactly where you stand
- 🎯 **Same engine, same scene** — no separate "VR build" to maintain

---

## ✦ 5. 3D Gaussian Splatting

> Native support for **3D Gaussian Splatting** — drop photo-scanned real-world scenes right next to traditional CAD meshes in the same viewport. Perfect for **as-built vs. as-designed** comparisons, site digital twins, and mixing reality capture with engineering models.

<div align="center">

<img src="capture/3dgs.png" alt="3D Gaussian Splatting scene" width="88%" />

</div>

**✨ Why it matters:**

- 📷 **Reality capture** — load `.ply` Gaussian Splat scans directly, no conversion pipeline needed
- 🔀 **Mixed scenes** — photo-real splats and parametric CAD geometry live in the same workspace
- 🎯 **As-built verification** — overlay site scans against design models to spot deviations
- 🌐 **Runs everywhere — yes, including the browser.** Desktop (DX12 / Vulkan) · **Web (WebGPU)** · in-headset (OpenXR). Splat scenes render fully in-browser with no plugins, no downloads, just a URL.

---

## 🗂️ 6. Workspace Management

> PPEngine persists an entire review session into a single **`.ppws`** workspace file — so your review work is reproducible, portable, and easy to share.

### 📄 What's inside a `.ppws`

| Section          | Contents                                                              |
| :--------------- | :-------------------------------------------------------------------- |
| 🎬 `scene`        | Loaded models (relative paths), camera viewpoint, background          |
| 📏 `measurements` | All measurement entries (distance, angle, clearance, ...)             |
| 📌 `markers`      | Annotation markers placed on the model                                |
| 👁️ `view_state`   | Clipping planes, explode state, component filters, render settings   |
| 🏷️ `meta`         | Name, description, created / modified timestamps, version            |

Models are referenced by **relative paths**, so a workspace folder (or packed `.ppz`) can be moved between machines without breaking links.

### 🧰 Operations — menu **Workspace**

| 🎛️ Action                  | 📝 Description                                                              |
| :------------------------ | :-------------------------------------------------------------------------- |
| 🆕 **New**                 | Clear the scene and start a blank `Untitled` workspace                      |
| 📂 **Open...**             | Load an existing `.ppws` workspace                                          |
| 💾 **Save / Save As...**   | Persist the current session; title bar shows `*` when unsaved              |
| 📤 **Export to Folder...** | Export the workspace with all referenced model files into a folder         |
| 📦 **Export as .ppz...**   | Pack workspace + all models into a single `.ppz` — perfect for sharing     |
| 🕘 **Recent Workspace**    | Quick access to recently-opened workspaces                                  |

### 🛡️ Lifecycle & safety

- 🔴 **Dirty tracking** — unsaved edits are tracked automatically; window title is flagged with `*`
- 💾 **Autosave** — background autosave protects against unexpected shutdown; recovery dialog appears on next launch
- ⚠️ **Unsaved-changes dialog** — closing or switching workspaces with pending edits triggers a confirmation
- 🔄 **Staged restore** — on load, models are fetched first (`LoadingModels`), then measurements / markers / view-state are re-applied (`RestoringAnnotations`) — ensuring clipping planes survive auto-fit

---

## 🔌 7. Extraction Plugins

> PPEngine consumes lightweight data produced by dedicated extractors. Two plugins ship out of the box:

### 🧲 7.1 AM Extractor — `PPAMExtractor.exe`

<div align="center">
<img src="capture/PPAMExtractor.png" alt="AM Extractor" width="70%" />
</div>

**📋 Prerequisites:** AM must be installed on the machine running the extractor.

**🚀 Steps:**

1. ▶️ Launch `PPAMExtractor.exe`
2. 🔑 Enter **Username**, **Password**, and **MDB** connection
3. 🎬 Click **Start** to extract

### 🛳️ 7.2 Tribon M3 Extractor — `PPM3Exporter.exe`

<div align="center">
<img src="capture/PPM3ExtractorV.png" alt="Tribon M3 Extractor" width="70%" />
</div>

**🚀 Steps:**

1. 🎯 In **Tribon M3**, use **Project Selection** to pick your project
2. ▶️ Launch `PPM3Exporter.exe` and choose the task type — **Block** · **Module** · **Pipe**
3. 🎬 Click **Start Export**
4. ⚡ Tune the **Workers** count — more workers = faster export

---

## 📖 8. Operation Manual

> The full operation manual ships **inside the release archive** — extract `PPEngineV1.8.5.7z` and open the included manual for detailed usage, hotkeys, and troubleshooting.

### 📦 Release archives

| 📁 Archive              | 📝 Contents                                            |
| :--------------------- | :---------------------------------------------------- |
| 🎨 `PPEngineV1.8.5.7z`  | PPEngine viewer **+ operation manual**               |
| 🧲 `PPAMExtractor.7z`   | AM extraction plugin                                  |
| 🛳️ `PPM3Exporter.7z`    | Tribon M3 extraction plugin                          |

---

## 📬 9. Contact

<div align="center">

### 🌟 Get in touch with the team

</div>

| 🎯 Purpose                                           | 📧 Contact                                                                                             |
| :-------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| 🆓 **Free model conversion server software**         | [**devin@pathplus.cn**](mailto:devin@pathplus.cn)                                                      |
| 💼 **Customized development & business inquiries**   | [**shanghai@pathplus.cn**](mailto:shanghai@pathplus.cn)                                                |

<br/>

<div align="center">

### 🏢 上海蹊加科技有限公司

**Shanghai PathPlus Technology Co., Ltd.**

🌐 **Website** &nbsp;·&nbsp; [**www.pathplus.cn**](https://www.pathplus.cn)

<br/>

---

<sub>© Shanghai PathPlus Technology Co., Ltd. &nbsp;·&nbsp; Made with 🛠️ for the shipbuilding & plant-design industry</sub>

</div>
