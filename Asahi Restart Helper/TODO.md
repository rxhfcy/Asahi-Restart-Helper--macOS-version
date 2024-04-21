# TODO LIST:

## Priority system for TODO items:
- **"1:" - Must have.** Critical, must not be omitted.
- **"2:" - Should have.** Important but not strictly necessary, can be delayed.
- **"3:" - Could have.** Desirable but not crucial, included if resources allow.
- **"4:" - Won't have.** Lowest priority, currently not planned.

## TODO items:
(please keep this TODO list up-to-date)

- [ ] (todo: add link to Linux version's TODO list)
- [ ] (todo: sync macOS and Linux TODO list)

# (NOTE: if you tweak something, please keep macOS/Linux TODOs synced!)

- [ ] 2: Make popover close/hide after user clicks "Restart..." and modal password dialog appears
    - slow UI animation forbids closing the popover, but works without animations?

- [ ] 1: Does the disk name need to be shown in the Restart confirmation popover or not?
    - leaning on probably implementing this just to always be super predictable and clear
    - why: makes it extremely clear what will happen next
    - why not: unnecessary? user clicked on the OS name literally less than a second ago
    - either implement
    - or remove test implementation

- [ ] 1: Code: add function to list every available Startup Disk
    - like this or is there a better method?
        1) list every /Volumes/ disk
        2) this is ugly but maybe tolerable: discard duplicates ending with " - Data",
            i.e. out of "Fedora Linux" and "Fedora Linux - Data" i.e. only use "Fedora Linux"
        3) out of the remaining, weed out removable drives etc: diskutil info -plist and look for the key bootable=true
           (there might have been other relevant keys too, research if necessary)
        4) display the disks in the menu:
            - the current "macOS" disk can be identified by the fact that macOS has currently mounted it to "/"
            - if only one other disk, it is assumed to be "Linux" (close enough)
            - if more than one other disk, list them all using their actual disk names instead of "Linux"

- [ ] 3: Refactor code: use separate function for "sudo bless --nextonly" etc

- [ ] 3: Refactor code: move some of the functions to separate files?

- [ ] 1: UI: List all disks in main menu, allow booting to any of them
    - if just macOS and Linux, show "macOS" and "Linux"
    - if more than 2 disks, list others than "/" (macOS) as full disk names (e.g. "Restart in 'Fedora Linux'...")
    - show the text "(default)" after current default Startup Disk

- [ ] 1: UI: Actually show "(default)" for the actual real current default Startup Disk in menu

- [ ] 1: Make it possible to add app to Login Items
    - app is pretty much useless if not already in the menubar ready to be used
    - use someone else's solution as reference?
    - if super simple, DIY?

- [ ] 2: Automatically add to / remove from Login Items if pref value disagrees with reality

- [ ] 1: Actually implement changing current default Startup Disk (submenu)
    - use a popover instead of a dialog so that it's correctly focused and button is the right color?

- [ ] 2: Proper Help dialog / popover
    - help icon in upper right corner of Preferences or something?
    - explain what the app does and why
      - "this app uses Apple's official `bless` tool with --nextonly to temporarily make e.g. Linux load after
        restarting next time (i.e. without having to change the default Startup Disk value)"
    - bonus: teach the possibility of using `sudo bless --mount` in Terminal.app and then restarting normally
        -> change OS for next time only
    - bonus: teach newbies the essential skill of holding down the power button to get to boot picker (show animation?) 
    - bonus: mention the Linux version of this tool (todo) and "Linux version of bless"
        (`sudo dnf install asahi-bless && sudo asahi-bless`)
    - link to Asahi web page (explain that we are not affiliated, at least not yet)?

- [ ] 2: Quit confirmation dialog
    - reason: user might click accidentally and not realize this removes the icon, explain that
        - especially if autostart on login not enabled: show a different message and a checkbox to add to Login Items?

- [ ] 2: Privileged helper app for password-free sudo bless
    - can i use someone else's work?
        "When you install a helper tool that requires elevated privileges (like using `sudo bless`), it's common to
        install it in the `/Library/PrivilegedHelperTools/` directory."
        "Here's an example of how you might install a helper tool:
        ```bash
        sudo cp /path/to/your/helper /Library/PrivilegedHelperTools/
        sudo chown root:wheel /Library/PrivilegedHelperTools/helper
        sudo chmod 755 /Library/PrivilegedHelperTools/helper
        ```
    - call helper app with volume name, always validate input and don't allow anything stupid or dangerous

- [ ] 2: Automatically install/uninstall privileged helper app if pref disagrees with reality

- [ ] 2: Detect if user cancelled an ongoing restart (i.e. used sudo bless but restart process failed for some reason)
    - otherwise, next "normal" restart (can be weeks from now!) will be very surprising ("why did the wrong OS load")? 
    - before bless command, store "NVRAM before" variable?
    - detect cancellation with e.g. a timer and/or checking for user interaction after having already "restarted"
    - read previously stored "NVRAM before", compare to "NVRAM now" and undo

- [ ] 1: Pick a name already? (naming is hard!)
    - ask for permission to use "Asahi"
    - (The suggestions below are in no particular order)
    - (GitHub Copilot AI was used to help come up with some of the options, e.g. the ones with "Selector" or "OS")
    - Restart in Linux (on macOS) / Restart in macOS (on Linux)
        - "The original", but the project now offers other restarting functionality as well
        - Also, the tool now aims to be installed by the Asahi Linux installer, hence "Asahi" in all other names.
    - Asahi Reboot Switcher
        - nohajc's original suggestion, definitely a worthy candidate but is "reboot" too technical?
    - Asahi Boot Menu
        - Very descriptive (i.e. replacement for the built-in "Apple Boot Menu")
    - Asahi Boot Menu Icon
        - Even more literal (i.e. an *icon* that opens the replacement for the built-in "Apple Boot Menu")
    - Asahi Boot Switcher
        - One of the AI-suggested names, discovered "independently" without knowledge of the previous option
    - Asahi Restart Switcher
        - Replace "reboot" with "restart"?
    - Asahi Restart Menu
        - A more beginner-friendly version, "Boot" replaced with the more commonly understood "Restart"
    - Asahi Restart Helper
        - Emphasizes the application's role as a tool that assists users in restarting their system
    - Asahi Restart Assistant
        - Variation on the same theme, similar to "Asahi Restart Helper"
    - Asahi Boot Assistant
        - Suggests that the application assists users in the boot process
    - Asahi Restart Icon
        - Too clumsy? Very literal and descriptive, the app does add an (Asahi) icon for restarting
    - Asahi Restart Helper Menu
        - This is getting ridiculous, almost certainly too long
    - Asahi Restart Helper Menu Icon
        - You must be joking
    - Asahi Restart
        - Very short, still at least somewhat communicates the application's main function (restarting)
    - Asahi OS Switcher
        - Emphasizes the app's role in switching between different operating systems
    - Asahi Switcher
        - Too vague? Same but without the "OS")
    - Asahi Linux Helper
        - Probably too general, this would leave room for other future "Asahi Linux" helper functionality (if desired)
    - Asahi Helper
        - Too vague and short? Focuses on the app's role as an Asahi helper tool, without specifying the exact function
    - Asahi OS Selector
        - Emphasizes the app's role in allowing users to select which **OS** to boot into
    - Asahi Boot Selector
        - Emphasizes the app's role in allowing users to select which OS to **boot** into
    - Asahi OS Menu
        - Highlights the app's function as a menu for selecting an **OS**
    - Asahi Use the Other OS
        - Extremely literal, i.e. spell out the reason the app exists in the first place

- [ ] 1: App icon OK?
    - ask for permission
    - provide all sizes?

- [ ] 1: Menubar icon OK?
    - ask for permission
    - use a "proper" (template?) icon instead that supports macOS dark/light theme?

- [ ] 2: GitHub blurb ok?
    - Compare with Linux version
    - "Asahi Restart Helper: macOS menubar app to easily Restart in Linux (btw add other Asahi Linux tools later?)"
    - "Asahi Restart Helper: Restart to Asahi Linux this time only (macOS menubar app)" 
    - "Asahi Restart Helper makes it easy to choose which OS / disk will be used to restart  
    (it can also change the default Startup Disk setting)"
    - Asahi Restart Helper (macOS version) is a macOS toolbar app that:
        - makes it easy to restart in Asahi Linux from macOS
        - for parity with Linux version of the app, offers an option to select default Startup Disk from within the app
        - maybe later: updates m1n1 (by launching the Asahi installer via a special command line argument?)
        - maybe later: add other Asahi installer related tasks (launch Asahi installer, etc?)
        - obviously will have to ask for permission before using the Asahi name but that won't be relevant for a while

- [ ] 3: Scope creep? What should the project (not) do?
    - Could the name be "Asahi Linux Helper" instead? Does the Asahi project want a more general "helper"?
    - note that Linux version could offer much less functionality for technical reasons
    - potential future "helper" functionality: update m1n1 bootloader
    - potential future "helper" functionality: run Asahi installer
    - potential future "helper" functionality (stretch goal): uninstall Asahi Linux

- [ ] 2: CLI installer: external apps (e.g. Asahi installer) to silently sudo install the app in an already useful state
    - require sudo
    - make app show icon (add to macOS Login Items) --add-to-login-items or something?
    - make app not ask password (install privileged helper app) --install-privileged-helper-app or something?
    - make app not ask questions (permission prompt can't be avoided, right?)
    - [ ] only ask for permission if not called by command line option is --consent-already-given-by-user or something
        - would this satisfy both the letter and spirit of "the law" and allow automatically
            - adding app to macOS startup? (yes/no)
            - installing helper tool? (yes/no)

- [ ] 2: Handle user having manually disabled macOS permission from System Settings (after having allowed it before)
    - probably needs another pref for "User has given system permission"
    - to test, always perform dummy action that requires same permissions (after pressing "Restart", before sudo bless)
        - if the dummy action failed (detect error code or variable), explain and offer link to correct place in
        System Settings (check if different in macOS 13/14/newer?)

- [ ] 3: Handle not having any other viable disks ("Linux")
    - why would anyone run the app with just the one OS?
    - explain that no other disk were detected
    - offer to run Asahi Linux installer?

- [ ] 3: Consider showing a user-friendly error if using Intel
    - reason: if release version is (accidentally?) built Universal, it will not show an error by default
    - reason why not: corner case (doesn't work, and pointless on Intel: Asahi Linux requires Apple Silicon)

- [ ] 2: Show something (Open the menu? Open preferences?) if user launches from Finder while app was already running
    - reason: maybe user is confused and doesn't notice the menubar icon?
    - reason why not: corner case, adds code complexity

- [ ] 3: Auto updater
    - use someone else's solution as reference?
    - if super simple, DIY?

- [ ] 3: Handle other errors (what? where?)

- [ ] 3: Uninstaller (don't leave privileged helper app and other cruft behind)?
    - remove privileged helper app
    - remove from Login Items
    - clear all prefs

- [ ] 3: Wording/strings ok?
    - "Restart in macOS" is the wording Apple's x86_64 Boot Camp uses in the app it adds on Windows 
    - I don't want to use "to" or "reboot" (be macOS-user-friendly, use familiar terminology)
    - what is the correct amount of detail in text and tooltips?
    - suggestions for wording/spelling (titles, tooltips)?

- [ ] 3: Write documentation
    - proper README.md
    - is anything else necessary?

- [ ] 3: Write tests
    - Unit tests
        - might need to sometimes use weird custom mock tests because the app writes to NVRAM, GitHub won't test that 
    - UI tests

- [ ] 1: Code signing
    - find someone willing to sign the code and ready to keep signing it for years...
    - or at least find some other tolerable way to not make users jump through hoops after installation

----------------------------------------

## 4: WON'T HAVE (not worth it / out of scope / feature creep, revisit this list periodically):

- [ ] 4: HOPEFULLY NOT NECESSARY? Add a pref for showing a checkbox under the Restarting menu items for always changing default when restarting
    - So a menu item like this here:
    -    "Restart in Linux..."
    -    "Restart macOS (current default)"
    - ☑️ "Also change the default"  <-- this one here, yuck
    - ...
    - why would someone want this: thinks that having to change the default is good (making a virtue out of necessity)?
    - why would someone want this: admittedly it is sometimes more simple if "restart always starts the same OS back up"
    - why not to implement: adds confusion to the super simple UI, possible to change the default manually from submenu

- [ ] 4: Warn first-time users about the permission prompt (access to control system events, needed for sudo bless)
    - when user clicks "Restart" the first time (if pref "user has used the app to restart at least once" is not set)
    - btw Dialog text: "“name-of-app.app” wants access to control “System Events.app”. Allowing control will provide
        access to documents and data in “System Events.app”, and to perform actions within that app."

- [ ] 4: Mimic "real" macOS system Restart... dialog even more closely?
    - add icon from system dialog?
    - justify text like in system dialog?
    - reason why not: current dialog is simple and does the job (impossible to add the "official" checkbox etc)

- [ ] 4: If "autoload" or "passwordless" prefs not enabled, try to convince user to enable prefs?
    - show button/checkbox in the main "Restart dialog"?
        - don't be deceptive or potentially destructive, users might thinks it's the "normal restart toggle"
          (users don't read text on screen)
    - reason why not: annoying + adds complexity, use an installer or write to prefs from an external app instead?
    - reason: most users would want both checkboxes to be enabled, i.e. password-free + show icon on macOS login?

- [ ] 4: Detect and indicate "real" Asahi Linux disks (e.g. detect step2 or something)
    - reason why not: fickle and hacky, Asahi Linux installation implementation details may change in the future
    - reason why not: what would be the actual benefit for the user?

- [ ] 4: Different UX if user chooses to restart to the current default Startup Disk (i.e. sudo bless not necessary)
    - if privileged helper not installed: instead of sudo bless password dialog, show "dummy" password dialog
        (instead of "randomly" skipping, to make the experience consistent regardless of Startup Disk setting?)
    - reason why not: why not just sudo bless anyway, realistically no harm will be caused by always writing to NVRAM
        (even though technically the flash chip NVRAM is using can wear down if written to infinitely many times) 
    - reason why not: not useful to annoy the user just to tell them information they already know?
        (completely reasonable to want to always Restart the same way, no matter what current default Startup Disk is)

- [ ] 4: If not enough room for main menu to open normally, open menu to left side of icon
    - reason why not: the popover already doesn't move to the left when it opens either, so UI "non-standard" anyway
    - reason why not: already tried to "fix", fixing seems difficult and error-prone

- [ ] 4: (I DON'T LIKE THIS) Ask user for "Linux" disk and only show that as "Restart in Linux..."
    - better: if only one Linux disk (should be majority of cases): just show "Restart in Linux..." in UI
    - better: if several, list actual names of all disks in the main menu
        - (e.g. "Restart macOS..." but "Restart using 'Linux 1'...", "Restart using 'Linux 2'..." etc)

- [ ] 4: (HOPEFULLY NOT NECESSARY) Implement some kind of first-use-wizard?
    - reason why not: UX should be good enough to not require wizard
    - reason why not: hopefully this can be achieved by settings prefs by external apps or preferences dialog
    - reason why not: even an installer is better than a wizard?

----------------------------------------

# Seek external feedback:

- [ ] Is it somehow possible to utilize the normal macOS "Restart..." dialog?
- [ ] Is it somehow possible to use the system checkbox to reopen windows (from the normal macOS "Restart..." dialog)?
- [ ] Without using a helper app, is it possible to sudo bless without asking for root password?
- [ ] Is there something fundamentally wrong with the approach, or is using sudo bless --nextonly inevitable?
- [ ] Is it possible to add colorful buttons in SwiftUI popovers "natively" without gross hacks (e.g. blue, or whatever the macOS preference is)?
- [ ] Any other hints to make the buttons / other controls more "native-looking"?
- [ ] Code review: fix code / style / other things?
- [ ] Menubar icon? Can I use someone else's work?
    - [ ] separate dark/light mode icons?
- [ ] App icon? Can I use someone else's work?
- [ ] Is it allowed for an external application (Asahi Linux installer) to ask for and "transfer" user's consent
    - [ ] To add *this* app to Login Items?
    - [ ] To make *this* app install a privileged helper tool?
    - [ ] OK to "transfer" consent via prefs (defaults write) or command line options for installer?
- [ ] UI text proofreading by a native speaker, someone with the relevant technical knowledge
- [ ] UX testing by both beginners and experts? Suggestions?
- [ ] Would the macOS/SwiftUI bugs I saw when opening dialogs/windows from a menubar icon have been avoidable?
    - Consider removing this item, the popovers are kind of nice and dialogs may no longer be necessary...

----------------------------------------

## Manual tests (test before releasing a new version and after major macOS updates?)

- [ ] Can some of these somehow be tested with normal Unit Tests / UI Tests?
- [ ] Build real releases with ARM64 / macOS 13.5+ only?
    - GitHub automation currently requires x86_64 and macOS 12.7.4 support
    - Maybe not worth the hassle to change these only for releases?
- [ ] What does running on Intel do? Show an error message? (doesn't work on Intel, so shouldn't launch)
- [ ] Does the app actually successfully do what it promises
    - Able to restart to any OS (all Linux and macOS disks)
    - Able to change the default Startup Disk
    - Other "Asahi Linux" tasks?
- [ ] Do the menus look wonky? What if the icon is moved to the right etc?
- [ ] Do the macOS/Linux versions of this app look and feel similar enough?
- [ ] Does restarting honor what the user has previously selected in the macOS system Restart dialog
    ("Reopen windows when logging back in")?
    - Test both settings, both "reopen" and "don't reopen", do the windows actually reopen after logging back in or not?
- [ ] Is cancelling before restarting handled gracefully?
- [ ] What does a brand new user (never used the app before) see? Is everything as simple and as automatic as possible?
- [ ] How many OS level permissions does the app require? Can fewer permission be used somehow?
- [ ] What happens if the default Startup Disk is already Linux/macOS and user tries to use the app to restart to that?
    - Is the UX different? Should it be? (No? Just always have consistent UX?)
- [ ] What happens if there are no "Linux" disks available?
- [ ] What happens if the user cancels an active restarting process? Is NVRAM now different than before?
- [ ] Does everything look fine with both macOS themes (Dark/Light)?
- [ ] Does "System Options / Accessibility / Keyboard settings / Keyboard navigation" behave like in other apps?
- [ ] Does making the app start at login work?
- [ ] Change all preferences in Options and restart the app, does reading/writing prefs work correctly?
- [ ] Does the app specifically ask user to make the app start at login if unset? Should it?
- [ ] Does the app automatically make reality agree with what value "auto start at login" pref has?
- [ ] Does the app automatically (password prompt needed though??) make reality agree with what the pref
    "install helper app" currently is?
- [ ] Does the app entry in both "Login Items" lists look OK (not a random mysterious name, use actual name of the app)
- [ ] Is behavior acceptable compared to current macOS "Restart..." dialog / workflow?
- [ ] Has something changed in macOS? Does something need to be changed in this app to compensate?
- [ ] Has a relevant Asahi Linux related thing changed? Does something need to be changed in this app to compensate?
- [ ] README and TODO: are macOS/Linux versions roughly similar, i.e. have they been kept in lockstep?
    - I sure hope so, must be annoying to fix it not
- [ ] The actual point of this project: Does using the Asahi Linux installer automatically add a "Restart in Linux"
    menubar icon in a useful state (works without password prompts or other silly questions & autoloads)?

----------------------------------------

(move tasks here after completing them)
## DONE:

- [x] Make the app appear in the menubar (as an icon)
- [x] Don't show Dock icon (the app is strictly menubar-only)
- [x] Implement popover functionality (because using "normal" dialogs and windows causes problems)
- [x] Placeholder app icon
- [x] Placeholder menubar icon
- [x] Basic localization support (English is the only actual localization implemented for now)
- [x] Initial list of manual tests (perform before every app release, and after new major macOS releases)
- [x] Placeholder "Quit" (in Options)
- [x] Initial menubar menu/popover hybrid UI
- [x] "Preferences...": placeholder for "show icon" / "password-free"
- [x] Placeholder testing support (dummy Unit Tests and UI Tests, currently only test if the app builds and launches)
- [x] 2: Confirmed that the app wouldn't even work on Intel (sudo bless --nextonly gives an error)
- [x] 1: Mock UI for changing default Startup Disk (submenu)
