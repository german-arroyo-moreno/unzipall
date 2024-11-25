# UnzipAll
A bash script to extract multiple ZIP files in a directory and organize them in a structured manner.

## My story behind this tool

As a university lecturer, I've spent countless hours reviewing student assignments and projects. But there's one task that's always been a thorn in my side: dealing with the chaos of student submissions. You see, when students upload their files to our learning management system, they often forget to organize them properly. I'd receive hundreds of ZIP files, each containing multiple documents, images, and folders, all jumbled together. It was like trying to find a needle in a haystack!

I'd spend hours extracting each file, one by one, only to discover that some students had nested ZIP files within ZIP files, making it a never-ending puzzle. It was frustrating, time-consuming, and took away from the time I could spend providing feedback and guidance to my students. I knew there had to be a better way.

That's why I created UnzipAll. I wanted to automate the process of extracting and organizing student submissions, so I could focus on what matters most: teaching and mentoring. With UnzipAll, I can now quickly and easily extract all the ZIP files in a directory, preserving the original structure and keeping everything tidy. It's been a game-changer for me, and I hope it will be for you too!

## How It Works

UnzipAll is a simple bash script that extracts multiple ZIP files in a directory and organizes them in a structured manner. The script is designed to be easy to use and efficient, making it perfect for educators and instructors who need to review student submissions.

## Features

Extracts all ZIP files in a specified directory (or current directory if none is specified)
Moves original ZIP files to a separate folder (__unzipped) to keep them organized
Preserves the original directory structure for easy access to extracted files
Safe to run multiple times without overwriting or mixing up existing extracted files
Usage

To use UnzipAll, simply navigate to the directory containing the ZIP files you want to extract and run the script. You can also specify a different directory as an argument.

```bash
./unzipall [path]
```

For help you can execute it with `-h` or `--help argument`:

```bash
./unzipall --help
```

## Why UnzipAll?

UnzipAll was created to solve a common problem faced by educators and instructors: the tedious task of extracting multiple ZIP files submitted by students. By automating this process, UnzipAll saves time and reduces the risk of human error.

Contributing

If you'd like to contribute to UnzipAll, please fork this repository and submit a pull request.

License

UnzipAll is licensed under the MIT License. See LICENSE for details.

