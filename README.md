# fzt-eib-configs 🛠️

This directory serves as a **local configuration hub** for building Endless OS images using the Endless Image Builder (EIB). It allows for **customization and overrides** of default EIB settings without modifying the main EIB source repository. This approach keeps your custom build settings **separate and manageable**, especially when updating the core EIB repository. The project is licensed under the **GNU General Public License (GPL) v2**.

## 📂 Directory Structure

This `fzt-eib-configs` directory is designed to mirror the `config/` and `hooks/` structures found in the main Endless Image Builder repository, enabling **specific overrides** for existing EIB settings.

```
fzt-eib-configs/
├── hooks/
│   └── image/
│       └── 51-sn-collector.chroot  # A hook to collect serial numbers on first boot
├── LICENSE                         # The GNU General Public License v2
└── README.md                       # This file
```

### File Breakdown

  * **`hooks/image/51-sn-collector.chroot`**: This shell script is a build hook that runs in a `chroot` environment. It sets up a **systemd service** and a script to collect the product serial number of OLPC devices on the first boot. The script is designed to run only once by creating a marker file (`/var/lib/olpc-sn-collector.done`) after completion.

-----

## 🚀 Getting Started

To use these configurations, you'll need to clone both the main `eos-image-builder` repository and this `fzt-eib-configs` repository. Note that the building process requires at least **30GB** of free disk space for the Endless OS base image configuration.

```
git clone https://github.com/porfiriopaiz/eos-image-builder
```

Then clone the custom configs:

```
git clone https://github.com/porfiriopaiz/fzt-eib-configs
```

Then, you can build an Endless OS image using the configurations defined in this directory. You will need to execute the main `eos-image-builder` script and specify this directory using the `--localdir` option.

**Example Custom Build Command:**

```
sudo ./eos-image-builder --localdir ../fzt-eib-configs --product eos --use-production-ostree eos6.0
```

### Listing Resulting Configurations

You can also list the resulting configurations after applying your custom settings using the `--show-config` option:

```
sudo ./eos-image-builder --show-config --localdir ../fzt-eib-configs --product eos --use-production-ostree eos6.0
```

This command will output the merged configuration settings, allowing you to confirm that your overrides were applied correctly.

**Command Breakdown:**

  * `--localdir ../fzt-eib-configs`: Tells the EIB to load configurations from this directory.
  * `--product eos`: Specifies the "eos" product configuration.
  * `--use-production-ostree eos6.0`: This option uses the production OSTree repository with the `eos6.0` branch to build the image.

-----

## 🔍 Listing Installed Applications

To see a list of applications that will be installed with the image, use the `--show-apps` option:

```
sudo ./eos-image-builder --show-apps --localdir ../fzt-eib-configs --product eos --use-production-ostree eos6.0
```

This command will output the names and sizes of the Flatpak applications included in the build, allowing you to verify what's being installed.

-----

## Locating the Build Artifacts

Once the building process is complete, all the resulting files, including the final ISO image, are stored in the `/var/cache/eos-image-builder` directory. You can navigate to this directory to find the ISO file built based on your provided settings.

```
cd /var/cache/eos-image-builder
```

Under `/var/cache/eos-image-builder`, you will find all the building artifacts inside the `tmp` directory.

The contents of the `tmp` directory include:

`applist` `build.txt` `config.ini` `fullconfig.ini` `manifest` `mnt` `ostree.txt` `out` `packages.txt`

And under `out`, you will find the ISO file.

Once under the `out` directory, insert a USB key with at least **8GB** of capacity and connect it to your PC. Then, run the `lsblk` command to identify the USB key's device name.

```
lsblk
```

Once you have identified the device (e.g., `/dev/sdb`), use the following command to write the ISO file to the USB. **Be careful to replace `/dev/sdb` with the correct device name for your USB key.**

```
sudo dd bs=4M if=eos-eos6.0-amd64-amd64.date-time.base.iso of=/dev/sdb conv=fsync oflag=direct status=progress
```
