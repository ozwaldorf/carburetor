# Building a color scheme with catppuccin-whiskers

Catppuccin has a tool called [whiskers](https://github.com/catppuccin/whiskers) which is used to create color schemes from template files. The [`carburetor-whiskers.json`](carburetor-whiskers.json) file in this folder can be used to generate a Carburetor color scheme for any template file that works with `whiskers`.

## Example: Zed
The same process should apply for whichever program you would like to create a Carburetor color scheme for.

1. [Install whiskers](https://github.com/catppuccin/whiskers?tab=readme-ov-file#installation)
2. Download the [template file for Zed](https://github.com/catppuccin/zed/blob/main/zed.tera)
3. (Optional) customize the template file as you like (e.g. changing the names of color schemes, etc.). Documentation for the template syntax `whiskers` uses is available [here](https://github.com/catppuccin/whiskers?tab=readme-ov-file#template).
4. Run (customizing the input filename and output format for your template):
```
whiskers zed.tera -o json --color-overrides carburetor-whiskers.json
```
5. `whiskers` should generate one or more color scheme files, dependent on the template. For Zed, it generates a `themes` directory with color scheme files for each accent color.
6. Install your color scheme!
