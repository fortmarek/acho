# Releasing

In this documents you'll find all the necessary steps to release a new version of `Simulator`.

> Although some of the steps have been automated, there are some of them that need to be executed manually.

1. Check out to the `master` branch.
2. Make sure that all the tests are passing with `swift test`.
3. Update the `CHANGELOG.md` adding a new entry at the top with the next version. Make sure that all the changes in the version that is about to be released are properly formatted. Commit the changes in `CHANGELOG.md`.
4. Commit, tag and push the changes to GitHub.
5. Create a new release on [GitHub](https://github.com/tuist/acho) including the information from the last entry in the `CHANGELOG.md`.

### Notes

- If any of the steps above is not clear above do not hesitate to propose improvements.
- Release should be done only by authorized people that have rights to crease releases in this repository and commiting changes to the Tap repository.
