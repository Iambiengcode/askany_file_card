:four_leaf_clover: Package help show File parameters and List File.

## :four_leaf_clover::four_leaf_clover: Preview

<p>
<img src="https://github.com/Iambiengcode/askany_file_card/blob/main/screenshots/light_theme.jpg?raw=true" width=180/>
<img src="https://github.com/Iambiengcode/askany_file_card/blob/main/screenshots/dark_theme.jpg?raw=true" width=180/>
</p>

## Features

- Support show file parameters and List file
- If the file doesn't exists in the phone, appear icon download

## Usage

- Show file

```dart
        FileCard(
            onTap: (String val){},
            fileBoxParamenters: FileBoxParamenters(
                brightness: Brightness.light,
                paddingHorizontal: 8,
                paddingVertical: 8,
                iconSize: 32,
                radiusBox: 7,
            ),
            filePath: file.path.toString(),
        ),
```

- Show List file

```dart
        ListFileCard(
            listPath: listFile,
            fileBoxParamenters: FileBoxParamenters(
                brightness: Brightness.light,
                paddingHorizontal: 8,
                paddingVertical: 8,
                iconSize: 32,
                radiusBox: 7,
            ),
            fileBoxParamentersCard: FileBoxParamenters(
                brightness: Brightness.light,
                paddingHorizontal: 8,
                paddingVertical: 8,
                iconSize: 32,
                radiusBox: 7,
            ),
            onTapCard: (val) {},
            physics: const BouncingScrollPhysics(),
        ),
```

### ReactionBoxParamenters

| parameter         | description                                          | default          |
| ----------------- | ---------------------------------------------------- | ---------------- |
| iconSize          | Size of icon File                                    | 32               |
| iconSpacing       | Space between icon and text                          | 8                |
| paddingHorizontal | Padding horizontal value for file card               | 8                |
| paddingVertical   | Padding vertical value for file card                 | 8                |
| radiusBox         | Radius circular of file box                          | 7                |
| brightness        | Set brightness for show background color compatitive | Brightness.light |

## Download Askany

<p>
<a href="https://apps.apple.com/vn/app/askany/id1589217505"><img src="https://askany.com/images/app-store.png" height="60px" width="180px"/></a>
<a href="https://play.google.com/store/apps/details?id=com.askany"><img src="https://askany.com/images/ch-play.png" height="60px" width="180px"/></a>
</p>

## License - lambiengcode

```terminal
MIT License

Copyright (c) 2022 Askany

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
