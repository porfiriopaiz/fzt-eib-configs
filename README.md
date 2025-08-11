# fzt-eib-configs 🛠️

This directory serves as the **local configuration hub** for building Endless OS images using the Endless Image Builder (EIB). It allows for **customization and overrides** of the default EIB settings without modifying the main EIB source repository.

Keeping your configurations here ensures that your custom build settings are **separate and easily manageable**, especially when updating the core EIB repository.

-----

## 📂 Directory Structure

This `fzt-eib-configs` directory is designed to mirror the `config/` and `data/` structures found in the main Endless Image Builder repository. This mirroring enables **specific overrides** for existing EIB settings, allowing for fine-grained control over your image builds.

```
fzt-eib-configs/
├── config/                  # Contains configuration files for overriding EIB defaults
│   ├── local.ini            # Primary file for general build-specific overrides
│   ├── private.ini          # (Optional) For sensitive information, not for version control
│   ├── schema.ini           # (Optional) For custom configuration schema definitions
│   ├── arch/                # (Optional) For custom architecture-specific overrides (e.g., amd64.ini)
│   ├── branch/              # (Optional) For custom branch-specific overrides (e.g., master.ini)
│   ├── personality/         # (Optional) For custom personality-specific overrides (e.g., base.ini)
│   ├── platform/            # (Optional) For custom platform-specific overrides
│   └── product/             # (Optional) For custom product-specific overrides (e.g., eos.ini)
│   └── product-personality/ # (Optional) For custom product-personality combinations (e.g., eos-base.ini)
├── buildscript/             # Contains custom build scripts and hooks
│   └── hooks/               # Place custom EIB hooks here
│       └── post-install.sh  # Example: A hook to inject files into the image's root filesystem
└── root-config/             # Files within this directory will be copied directly into the image's root (/) filesystem
    ├── etc/                 # Example: Place custom systemd services or configuration files here
    │   └── systemd/
    │       └── system/
    │           └── my-first-run.service
    └── usr/                 # Example: Place custom scripts or binaries here
        └── local/
            └── bin/
                └── my-first-run.sh
```

  * **`config/`**: Any `.ini` file placed here, mirroring the EIB's `config/` structure, will **override** the corresponding default settings from the main EIB repository. `local.ini` is the most commonly used file here for general overrides.
  * **`buildscript/hooks/`**: Custom scripts placed here (e.g., `post-install.sh`) will be executed as hooks during the EIB build process. The EIB automatically looks for and runs these scripts at predefined stages.
  * **`root-config/`**: This directory allows you to directly inject files and directories into the **root filesystem of the built Endless OS image**. Any file structure under `root-config/` will be replicated exactly within the target image.

-----

## 🚀 Usage

To build an Endless OS image using the configurations defined in this directory, navigate to your main `eos-image-builder` directory and execute the `eos-image-builder` script, specifying this directory with the `--localdir` option.

**Example Command:**

```bash
sudo ./eos-image-builder --localdir ../fzt-eib-configs --product eos --personality base --arch amd64 master
```

### Command Breakdown:

  * **`sudo ./eos-image-builder`**: Invokes the Endless Image Builder script. `sudo` is often required for disk image creation and manipulation.
  * **`--localdir ../fzt-eib-configs`**: Tells the EIB to load additional configuration files from the `fzt-eib-configs` directory. This path is relative to where you execute the `eos-image-builder` script.
  * **`--product eos`**: Specifies the "eos" product configuration. The EIB will look for `config/product/eos.ini` in both the main EIB source and your local `fzt-eib-configs/config/product/` directory.
  * **`--personality base`**: Specifies the "base" image personality. The EIB will load `config/personality/base.ini`.
  * **`--arch amd64`**: Specifies the `amd64` architecture. The EIB will load `config/arch/amd64.ini`.
  * **`master`**: Indicates that the image should be built from the `master` branch of the OSTree filesystem tree. The EIB will load `config/branch/master.ini`.

By combining these options, the EIB will merge configurations from its defaults, the specified product, personality, architecture, branch, and any corresponding override files found within your `fzt-eib-configs` directory.
