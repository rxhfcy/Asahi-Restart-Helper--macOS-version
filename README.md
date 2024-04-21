```diff
- FIXME: We're considering 4 UI options
- and can't decide which one is best.
```

**Option A (THIS README)**: Boot menu.
This option lets users select from all disks and restart **WITHOUT CHANGING** the default 'Startup Disk'.
However, it does provide a submenu for changing the default 'Startup Disk'.

This is currently the only version implemented on macOS. 
Once we've decided on the best compromise for 
[the Linux version](https://github.com/rxhfcy/Asahi-Restart-Helper--Linux-version) (**Option Y**? **Option A**?),
the macOS version will be updated to match the UI of the Linux version.

---

# Asahi Linux Helper<br>(macOS version)

<img src="./misc/Menu_Screenshot.png" width="25%" alt="Main menu screenshot"><br>

***A faster alternative to the "hidden" Apple silicon Boot Menu.***

**Asahi Restart Helper (macOS version)** makes it easy to
restart the computer into [Asahi Linux](https://asahilinux.org/).

**NOTE: You should also install the
[corresponding Linux version](https://github.com/rxhfcy/Asahi-Restart-Helper--Linux-version),<br>
to make it equally easy to return back to macOS from Linux!**

## Usage

Click the system tray icon and select the OS you want to restart into:

- **Restart in Linux**: Restart and load **Linux** this time, even if Linux is the default.
- **Restart macOS**: or Restart *back into macOS*, even if Linux is the default.

Or use the other menu items:

- **Change default 'Startup Disk'**: Use this submenu if you want to change the default 'Startup Disk' setting.
- **Preferences**: This dialog allows you to enable showing the icon after logging in, or to set up password-free usage.

Restarting never changes the default 'Startup Disk' setting.

The 'Startup Disk' determines the operating system the computer always loads by default after shutting down,
or after restarting "normally" without using this application.

The current default is indicated in the menu with a "(current default)" label.

## Features

- **Fast and Easy to Use**: Just click the icon and select the OS you want to use next.
- **Doesn't Force 'Startup Disk' Change**: Current default 'Startup Disk' setting will not change
  unless you *choose* to change it from the submenu.
- **Same Boot Menu GUI on Both macOS and Linux**: Use the same GUI on both operating systems by
  also installing the corresponding
  [Linux version](https://github.com/rxhfcy/Asahi-Restart-Helper--Linux-version) on Linux.

## Who should use it and why?

Beginners and expert users alike benefit from using this application.
It simplifies dual-booting Linux and macOS on Apple Silicon Macs. Apple's native boot menu is "hidden" on start-up,
hard to access, and slow to use, leaving room for improvement.
The application fills this gap by offering a more convenient "OS picker" or "boot menu".

Apple has intentionally made it difficult to use any OS other than macOS.
This project aims to mitigate the friction caused by Apple's design decisions
when using two or more operating systems on the computer.

Because Apple decided to not allow showing the boot menu on start-up,
they also had to introduce the somewhat confusingly named concept of the 'Startup Disk',
which determines the default OS that is always loaded after shutting down the computer or restarting it "normally"
using the native OS restart functionality.
This application also simplifies restarting into Linux itself,
even if macOS happens to currently be set as the 'Startup Disk'.

## Screenshots:

<img src="./misc/Menu_Screenshot.png" width="50%" alt="Main menu screenshot"><br>
1\. Click "Restart in Linux..." from the menu to restart in Linux next.<br>
(i.e. restart in Linux this time only without changing the default Startup Disk!)

---

<img src="./misc/Restart_Dialog_Screenshot.png" width="50%" alt="Restart dialog screenshot"><br>
2\. Then click "Restart now!" from the Restart dialog.
The system will restart without asking any further questions (if the correct permissions etc are set).

---

<img src="./misc/Change_Default_Screenshot.png" width="50%" alt="Change default startup disk dialog"><br>
The app can also be used to change the default Startup Disk directly from the menu<br>

---

## Build the App with Xcode:

1. Clone this repository:<br>
   `git clone https://github.com/rxhfcy/Asahi-Restart-Helper--macOS-version.git`<br>
   or download the
   [zip file](https://github.com/rxhfcy/Asahi-Restart-Helper--macOS-version/archive/refs/heads/main.zip)
   and extract it
3. Launch Xcode, choose "Open Existing Project..."
4. Navigate to the new folder (Xcode will automatically look for and open the `.xcodeproj` bundle)
5. You should now be able to build and test the project (please open a new issue if that was not the case!)

## Download initial demo version:

Download:  
[Asahi Linux Helper.app.zip](./misc/Asahi%20Linux%20Helper.app.zip)

- Self-signed
- UI demo only
- Doesn't actually restart yet
- Doesn't actually change default 'Startup Disk' yet

## Technical overview

This application provides a GUI that replaces the "hidden" native boot menu
by running the Apple's `bless` tool with the `--nextonly` argument.
This adds a temporary NVRAM parameter (`alt-boot-volume`) for this restart only,
leaving the default 'Startup Disk' setting (the `boot-volume` NVRAM parameter) unchanged
unless the user explicitly modifies it using the submenu.

The application was designed to
not always change the default 'Startup Disk' setting when switching to the other OS,
because this can arguably prevent confusion for users who don't want to have to
always keep track of the current default setting after shutting down the computer
(i.e. to make it more predictable which OS will load after starting up the computer in that case).
It is arguably best to use whichever OS is used more frequently as the default Startup Disk,
instead of continuously changing it for little reason,
which can make the 'Startup Disk' setting itself feel almost random and useless.

When exactly two bootable disks are detected, the current disk is always displayed as "macOS" in the menu,
and the other disk is assumed to be the "Linux" disk.
If three or more disks are detected, any other disks are listed in the menu using their full disk names in this case.

Note: macOS does not permit apps to directly use the standard macOS Restart dialog, so a custom dialog must be used.
However, the custom restart appears to respect any previously selected "Reopen windows when logging back in" setting
from the aforementioned system restart dialog (TODO: verify).

## Requirements

- Apple silicon Mac (Asahi Linux is ARM64-only)
- Both Asahi Linux and macOS must be installed on the computer

## Contributing

Contributions are welcome! Please open a new issue or pull request.

## License

This project is licensed under the [MIT License](./LICENSE).

## Project goals

The ultimate goal of this project is to have the icon installed by default (both on Linux and macOS)
automatically after the user installs Asahi Linux.

- **Linux System Tray icon**: The goal is to convince Asahi Linux distributions (Fedora Asahi Remix, others?) 
  to automatically install the Linux version of this application (add the icon in Linux/KDE System Tray)
  - Also install a GNOME extension that allows showing the System Tray icon
   on GNOME?
- **macOS menubar icon**: The goal is to also convince the Asahi Linux installer to automatically install
  the macOS version of this application (add the icon in macOS menubar)
- **Rationale**: This would benefit all users, especially beginners who e.g. don't already know the
  correct "arcane spell" to switch to macOS from Linux (`sudo dnf install asahi-bless && sudo asahi-bless`)

# See also: [TODO.md](./Asahi%20Restart%20Helper/TODO.md)
