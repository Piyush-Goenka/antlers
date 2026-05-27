# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.5.0

### Added

- Pass props to initialize when method is present

### Changed

- Standardise falling back to a user defined string

## 0.4.0

### Added

- Support key/value iteration of hashes in for loop (`<{ for: key, value in: @items }>`)
- Support method chain syntax `{ variable.method }`

## 0.3.0

### Added

- Introduce for loop (`<{ for: user in: @users }>`)

### Changed

- Rename `Antlers.parse` to `Antlers.ast`

## 0.2.0

### Added

- Support props
- Support slots
- Support variables

## 0.1.0

### Added

- Add lexer
- Add parser

## 0.0.0

### Added

- Basic template
