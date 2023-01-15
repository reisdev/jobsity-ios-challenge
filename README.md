# Jobsity iOS Challenge

## Setup

To run this project you must open the `JobsityChallenge.xcodeproj` file using the Xcode.
After opening it, you need to create a Property List(`.plist`) file under the `Resources` folder called `TVMaze`.
This file should contain two key-values: `API_KEY` and `API_URL`. The `API_KEY` can be obtained on the [TVMaze dashboard](https://www.tvmaze.com/dashboard).
The `API_URL` is currently `https://api.tvmaze.com`, but, as it can change in the future, I decided to keep it in this file too.

## Depedencies

This project has a single dependency, `Kingfisher`, for downloading images from web. The depedencies are managed using the `Swift Package Manager`.

## Features checklist

1. [x] List all of the series contained in the API used by the paging scheme provided by the
API.
2. [x] Allow users to search series by name.
3. [x] The listing and search views must show at least the name and poster image of the
series.
4. [x] After clicking on a series, the application should show the details of the series, showing
the following information: name, poster, days and time during which the series airs, genres, summary, episodes separated by season
5. [x] After clicking on an episode, the application should show the episode’s information, name, number, season, summary and image(if there is one)

## Screenshots

| Feature | Screenshot |
| ------- | ---------- |
| List series with pagination | <img width=300 src="https://user-images.githubusercontent.com/23380987/212523410-b263188a-5015-4a45-9d3f-19283e6a13b2.png"> |
| Search by name | <img width=300 src="https://user-images.githubusercontent.com/23380987/212523419-2c1bc63a-3a34-44ae-af3a-3d47088dc151.png"> |
| Series details | <img width=300 src="https://user-images.githubusercontent.com/23380987/212523491-356862ac-3119-4764-8dee-62fa6d78a913.png"> |
| List episodes | <img width=300 src="https://user-images.githubusercontent.com/23380987/212523459-2531e671-cdfd-40dc-a1ca-3455a8b79631.png"> |
| Episode details | <img width=300 src="https://user-images.githubusercontent.com/23380987/212523473-10542499-6a2d-4d97-bf81-d6879443b1b0.png"> |

## Final notes

- I choose MVVM to build this because it was a great match for the project. It's simple but organized.
- Kingfisher saved me a lot of time, since downloading images wasn't a thing.
- The network layer I created was very useful, because I only had to worry about the data, and not with the requests itself.
- Working without UI mockup is always challenging. I tried to do my best :)

This app was made with ❤️.
