# NAMESPACE_AUDIT_V1

## Purpose

Record exact namespace and application identity residue.

## Android Namespace

| File | Exact Text | Classification | Action |
| --- | --- | --- | --- |
| `android/app/build.gradle.kts:33` | `namespace = "com.mentalkey.app.flutterprojects"` | RENAME | Replace in Android identity execution phase. |
| `android/app/build.gradle.kts:48` | `applicationId = "com.mentalkey.app.flutterprojects"` | RENAME | Requires Owner decision because it affects app identity and store continuity. |
| `android/app/src/main/kotlin/com/mentalkey/app/flutterprojects/MainActivity.kt:1` | `package com.mentalkey.app.flutterprojects` | RENAME | Must move Kotlin path and package together. |

## Windows Namespace / Product Metadata

| File | Exact Text | Classification | Action |
| --- | --- | --- | --- |
| `windows/CMakeLists.txt:3` | `project(flutterprojects LANGUAGES CXX)` | RENAME | Replace if Windows target survives. |
| `windows/CMakeLists.txt:7` | `set(BINARY_NAME "flutterprojects")` | RENAME | Replace if Windows target survives. |
| `windows/runner/main.cpp:30` | `window.Create(L"flutterprojects", origin, size)` | RENAME | Replace visible window title. |
| `windows/runner/Runner.rc:92` | `CompanyName`, `com.mentalkey.app` | RENAME | Replace if Windows target survives. |
| `windows/runner/Runner.rc:93` | `FileDescription`, `flutterprojects` | RENAME | Replace if Windows target survives. |
| `windows/runner/Runner.rc:95` | `InternalName`, `flutterprojects` | RENAME | Replace if Windows target survives. |
| `windows/runner/Runner.rc:96` | `com.mentalkey.app` copyright | RENAME | Replace if Windows target survives. |
| `windows/runner/Runner.rc:97` | `OriginalFilename`, `flutterprojects.exe` | RENAME | Replace if Windows target survives. |
| `windows/runner/Runner.rc:98` | `ProductName`, `flutterprojects` | RENAME | Replace if Windows target survives. |

## Active Label

| File | Exact Text | Classification |
| --- | --- | --- |
| `android/app/src/main/AndroidManifest.xml:3` | `android:label="Mental Smile"` | KEEP |

## Risk

Android identity change is high-risk because `applicationId` affects Firebase app registration, Play Store identity, installed app continuity, and Google services files.
