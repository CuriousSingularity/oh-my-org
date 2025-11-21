#!/usr/bin/env bash
# Weather plugin for Oh My Dev
# Fetches weather information using wttr.in service
#
# USAGE EXAMPLES:
#
# 1. Get weather for default city (bangalore):
#    $ weather
#
# 2. Get weather for a specific city:
#    $ weather london
#    $ weather "new york"
#
# 3. Get weather with different detail levels (0-3):
#    $ weather bangalore 0    # One-line weather
#    $ weather bangalore 1    # Compact view (default)
#    $ weather bangalore 2    # Full view
#
# 4. Get weather with custom parameters:
#    $ weather bangalore 1 "format=%t"       # Temperature only
#    $ weather bangalore 1 "format=%C+%t"    # Condition + Temperature
#    $ weather bangalore 1 "lang=es"         # Spanish language
#
# 5. Quick aliases:
#    $ w                      # Default weather
#    $ weather-full london    # Full weather report
#    $ weather-short paris    # One-line weather

# Main weather function
# Fetches weather information for a specified city using wttr.in
#
# Arguments:
#   $1 - city (optional): City name, defaults to "bangalore"
#   $2 - level (optional): Detail level (0-3), defaults to "1"
#   $3 - parameters (optional): Additional query parameters
#
# Examples:
#   weather
#   weather london
#   weather "new york" 2
#   weather paris 1 "format=%C+%t"
weather() {
  local city="${1:-bangalore}"
  local level="${2:-1}"
  local parameters="${3:-}"

  # Validate detail level
  if [[ ! "$level" =~ ^[0-3]$ ]]; then
    echo "Error: Detail level must be 0, 1, 2, or 3" >&2
    echo "" >&2
    echo "Usage: weather [city] [level] [parameters]" >&2
    echo "  level 0: One-line weather" >&2
    echo "  level 1: Compact view (default)" >&2
    echo "  level 2: Full view" >&2
    echo "  level 3: Full view with additional info" >&2
    return 1
  fi

  # Try to fetch weather with retries
  local max_retries=3
  local timeout=5

  for i in $(seq 1 $max_retries); do
    if curl -m "$timeout" -s "wttr.in/$city?$level$parameters"; then
      return 0
    fi

    # If not the last retry, wait a bit
    if [[ $i -lt $max_retries ]]; then
      sleep 1
    fi
  done

  echo "Error: Failed to fetch weather after $max_retries attempts" >&2
  echo "Please check your internet connection or try again later" >&2
  return 1
}

# Get full weather report (detail level 2)
# Arguments:
#   $1 - city (optional): City name, defaults to "bangalore"
weather_full() {
  local city="${1:-bangalore}"
  weather "$city" 2
}

# Get short one-line weather
# Arguments:
#   $1 - city (optional): City name, defaults to "bangalore"
weather_short() {
  local city="${1:-bangalore}"
  weather "$city" 0
}

# Get current temperature only
# Arguments:
#   $1 - city (optional): City name, defaults to "bangalore"
weather_temp() {
  local city="${1:-bangalore}"
  weather "$city" 1 "format=%t"
}

# Get current condition and temperature
# Arguments:
#   $1 - city (optional): City name, defaults to "bangalore"
weather_now() {
  local city="${1:-bangalore}"
  weather "$city" 1 "format=%C+%t"
}

# Get weather in different language
# Arguments:
#   $1 - city (required): City name
#   $2 - lang (required): Language code (e.g., es, fr, de, ru, zh)
weather_lang() {
  local city="${1:-bangalore}"
  local lang="${2:-en}"

  if [[ -z "$lang" ]]; then
    echo "Error: Language code required" >&2
    echo "Usage: weather_lang <city> <lang>" >&2
    echo "Example: weather_lang london es" >&2
    return 1
  fi

  weather "$city" 1 "lang=$lang"
}

# Show weather help and examples
weather_help() {
  cat << 'EOF'
Weather Plugin - Powered by wttr.in

USAGE:
  weather [city] [level] [parameters]

ARGUMENTS:
  city       - City name (default: bangalore)
  level      - Detail level 0-3 (default: 1)
               0: One-line weather
               1: Compact view
               2: Full view
               3: Full view with additional info
  parameters - Additional query parameters

EXAMPLES:
  weather                          # Default weather (bangalore, level 1)
  weather london                   # Weather for London
  weather "new york" 2             # Full weather for New York
  weather paris 1 "format=%t"      # Temperature only for Paris

QUICK FUNCTIONS:
  weather-full <city>              # Full weather report (level 2)
  weather-short <city>             # One-line weather (level 0)
  weather-temp <city>              # Temperature only
  weather-now <city>               # Current condition + temperature
  weather-lang <city> <lang>       # Weather in different language

CUSTOM FORMATS:
  format=%C                        # Weather condition
  format=%t                        # Temperature
  format=%w                        # Wind
  format=%h                        # Humidity
  format=%p                        # Precipitation
  format=%C+%t                     # Condition + Temperature

LANGUAGES:
  lang=es                          # Spanish
  lang=fr                          # French
  lang=de                          # German
  lang=ru                          # Russian
  lang=zh                          # Chinese

MORE INFO:
  Visit https://github.com/chubin/wttr.in for advanced usage
EOF
}

# Useful aliases
alias w='weather'
alias weather-full='weather_full'
alias weather-short='weather_short'
alias weather-temp='weather_temp'
alias weather-now='weather_now'
alias weather-lang='weather_lang'
alias weather-help='weather_help'
