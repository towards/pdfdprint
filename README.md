# PDF Direct Print

Allows you to print PDF files directly to a modern network-enabled printer supporting raw PDF printing on TCP port 9100 from the command line.

## Prerequisites

- Ruby
- Network-enabled printer supporting direct PDF printing

## Installation

```shell
gem install pdfdprint
```

## Usage

```
Usage: pdfprint [options] [filename|directory]

    -f, --format=FORMAT              Paper format (default: A4)
    -m, --move=DIRECTORY             Move PDF file to DIRECTORY after printing
    -o, --port=PORT                  Printer TCP port (default: 9100)
    -p, --printer=PRINTER            Printer hostname or IP address
    -r, --resolution=RESOLUTION      Print resolution in dpi (default: 300)
    -t, --tray=TRAY                  Paper tray number (default: 0)
    -w, --wait=TIME                  Wait time in seconds between files to be printed (default: 1)
```

## Examples

### Print one single PDF file using printer IP

```
$ pdfdprint -p 192.168.1.200 /home/me/Documents/Report.pdf
```

### Print all PDF files located in Documents directory using printer hostname

```
$ pdfdprint -p myprinter /home/me/Documents
```

## Tested with

* HP LaserJet Pro MFP M521

## Troubleshooting

### Unsupported Personality: UNKNOWN

If your printer only prints out the `Unsupported Personality: UNKNOWN` text this means that your printer does not support direct PDF printing.

## Authors

- Marc - [towards | Ruby & Web Development](https://towards.ch)

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details
