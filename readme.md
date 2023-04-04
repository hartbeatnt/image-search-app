# Instructions for running the app
The application will not build until you add a `Secrets` enum. This data is not included in the repo for obvious reasons. I recommend that you place this enum in a file with the path `image-search/Secrets/Secrets.swift` as any file at this path will be ignored by git, so you can safely fork without worrying about pushing your api tokens to github. There is a file called `image-search/Secrets/Secrets.swift` that has a commented-out example enum you can use for reference.

Once the Secrets enm is created (and you have ensured that the file is part of the project target), building should be as simple as opening the project in xcode and running it