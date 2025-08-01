# This script fetches weather information for a specified city using wttr.in.
# 
# Usage:
#   ./weather.sh [city] [level] [parameters]
#
# Arguments:
#   city       (optional) The name of the city for which to fetch the weather.
#              Defaults to "bangalore" if not provided.
#   level      (optional) The detail level of the weather report.
#              Defaults to "1" if not provided.
#   parameters (optional) Additional query parameters to customize the request.
#
# Example:
#   ./weather.sh london 2 "format=%t"
#   This fetches the weather for London with detail level 2 and a custom format.
city=${1:-bangalore}
level=${2:-1}
parameters=${3:-""}
curl "wttr.in/$city?$level$parameters"