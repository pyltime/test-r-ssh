# Test R SSH
Simple application for testing SSH client in R (https://github.com/ropensci/ssh) in a Shiny app.

## Usage
Set environment variables in `.Renviron` (see `.Renviron-example`), RStudio Connect's "Variables"-section or somewhere else:
- `target_username`
- `target_password`
- `target_server`

In app the upload a file, wait until file is displayed in table, and click `Run` for executing the SSH command.
