###############
# air_quality #
###############
Display air quality polluting in a given location.

An air quality index (AQI) is a number used by government agencies to communicate
to the public how polluted the air currently is or how polluted it is forecast to
become. As the AQI increases, an increasingly large percentage of the population
is likely to experience increasingly severe adverse health effects. Different
countries have their own air quality indices, corresponding to different national
air quality standards.

Configuration parameters:
    auth_token: Personal token required. See https://aqicn.org/data-platform/token
        for more information. (default 'demo')
    cache_timeout: refresh interval for this module. A message from the site:
        The default quota is max 1000 requests per minute (~16RPS) and with
        burst up to 60 requests. See https://aqicn.org/api/ for more information.
        (default 3600)
    format: display format for this module
        (default '[\?color=aqi {city_name}: {aqi} {category}]')
    format_datetime: specify strftime characters to format (default {})
    location: location or uid to query. To search for nearby stations in Kraków,
        try `https://api.waqi.info/search/?token=YOUR_TOKEN&keyword=kraków`
        For best results, use uid instead of name in location, eg `@8691`.
        (default 'Shanghai')
    quality_thresholds: specify a list of tuples, eg (number, 'color', 'name')
        *(default [(0, '#009966', 'Good'),
        (51, '#FFDE33', 'Moderate'),
        (101, '#FF9933', 'Sensitively Unhealthy'),
        (151, '#CC0033', 'Unhealthy'),
        (201, '#660099', 'Very Unhealthy'),
        (301, '#7E0023', 'Hazardous')])*
    thresholds: specify color thresholds to use (default {'aqi': True})

Notes:
        Your station may have individual scores for pollutants not listed below.
        See https://api.waqi.info/feed/@UID/?token=TOKEN (Replace UID and TOKEN)
        for a full list of placeholders to use.

Format placeholders:
    {aqi} air quality index
    {attributions_0_name} attribution name, there maybe more, change the 0
    {attributions_0_url} attribution url, there maybe more, change the 0
    {category} health risk category, eg Good, Moderate, Unhealthy, etc
    {city_geo_0} monitoring station latitude
    {city_geo_1} monitoring station longitude
    {city_name} monitoring station name
    {city_url} monitoring station url
    {dominentpol} dominant pollutant, eg pm25
    {idx} Unique ID for the city monitoring station, eg 7396
    {time} epoch timestamp, eg 1510246800
    {time_s} local timestamp, eg 2017-11-09 17:00:00
    {time_tz} local timezone, eg -06:00
    {iaqi_co}   individual score for pollutant carbon monoxide
    {iaqi_h}    individual score for pollutant h (?)
    {iaqi_no2}  individual score for pollutant nitrogen dioxide
    {iaqi_o3}   individual score for pollutant ozone
    {iaqi_pm25} individual score for pollutant particulates
        smaller than 2.5 μm in aerodynamic diameter
    {iaqi_pm10} individual score for pollutant particulates
        smaller than 10 μm in aerodynamic diameter
    {iaqi_pm15} individual score for pollutant particulates
        smaller than than 15 μm in aerodynamic diameter
    {iaqi_p}    individual score for pollutant particulates
    {iaqi_so2}  individual score for pollutant sulfur dioxide
    {iaqi_t}    individual score for pollutant t (?)
    {iaqi_w}    individual score for pollutant w (?)

    AQI denotes an air quality index. IQAI denotes an individual AQI score.
    Try https://en.wikipedia.org/wiki/Air_pollution#Pollutants for more
    information on the pollutants retrieved from your monitoring station.

format_datetime placeholders:
    key: epoch_placeholder, eg time, vtime
    value: % strftime characters to be translated, eg '%b %d' ----&gt; 'Nov 11'

Color options:
    color_bad: print a color for error (if any) from the site

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Examples:
```
# show last updated time
air_quality {
    format = '{city_name}: {aqi} {category} - {time}'
    format_datetime = {'time': '%-I%P'}
}
```

@author beetleman, lasers
@license BSD
###############
# apt_updates #
###############
Display number of pending updates for Debian based Distros.

Thanks to Iain Tatch &lt;iain.tatch@gmail.com&gt; for the script that this is based on.
This will display a count of how many 'apt' updates are waiting to be installed.

Configuration parameters:
    cache_timeout: How often we refresh this module in seconds (default 600)
    format: Display format to use
        (default 'UPD[\?not_zero : {apt}]')

Format placeholders:
    {apt} Number of pending apt updates

Requires:
    apt: Needed to display pending 'apt' updates

@author Joshua Pratt &lt;jp10010101010000@gmail.com&gt;
@license BSD
################
# arch_updates #
################
Display number of pending updates for Arch Linux.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 600)
    format: display format for this module, otherwise auto (default None)
    hide_if_zero: don't show on bar if True (default False)

Format placeholders:
    {aur} Number of pending aur updates
    {pacman} Number of pending pacman updates
    {total} Total updates pending

Requires:
    pacman-contrib: contributed scripts and tools for pacman systems
    auracle: a flexible command line client for arch linux's user repository
    trizen: lightweight pacman wrapper and AUR helper
    yay: yet another yogurt. pacman wrapper and aur helper written in go
```

@author Iain Tatch <iain.tatch@gmail.com>
@license BSD

################
# async_script #
################
Display output of a given script asynchronously.

Always displays the last line of output from a given script, set by
`script_path`. If a line contains only a color (/^#[0-F]{6}$/), it is used
as such (set force_nocolor to disable). The script may have parameters.

Configuration parameters:
    force_nocolor: if true, won't check if a line contains color
        (default False)
    format: see placeholders below (default '{output}')
    script_path: script you want to show output of (compulsory)
        (default None)
    strip_output: shall we strip leading and trailing spaces from output
        (default False)

Format placeholders:
    {output} output of script given by "script_path"

Examples:
```
async_script {
    format = "{output}"
    script_path = "ping 127.0.0.1"
}
```

@author frimdo ztracenastopa@centrum.cz, girst
############
# aws_bill #
############
Display bill for Amazon Web Services.

**WARNING: This module generate some costs on the AWS bill.
Take care about the cache_timeout to limit these fees!**

Configuration parameters:
    aws_access_key_id: Your AWS access key (default '')
    aws_account_id: The root ID of the AWS account
        Can be found here` https://console.aws.amazon.com/billing/home#/account
        (default '')
    aws_secret_access_key: Your AWS secret key (default '')
    billing_file: Csv file location (default '/tmp/.aws_billing.csv')
    cache_timeout: How often we refresh this module in seconds (default 3600)
    format: string that formats the output. See placeholders below.
        (default '{bill_amount}$')
    s3_bucket_name: The bucket where billing files are sent by AWS.
        Follow this article to activate this feature:
        https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-reports.html
        (default '')

Format placeholders:
    {bill_amount} AWS bill amount

Color options:
    color_good: Balance available
    color_bad: An error has occurred

Requires:
    boto: a python interface to amazon web services (aws)

@author nawadanp
#############
# backlight #
#############
Adjust screen backlight brightness.

Configuration parameters:
    brightness_delta: Change the brightness by this step.
        (default 8)
    brightness_initial: Set brightness to this value on start.
        (default None)
    brightness_minimal: Don't go below this brightness to avoid black screen
        (default 1)
    button_down: Button to click to decrease brightness. Setting to 0 disables.
        (default 5)
    button_up: Button to click to increase brightness. Setting to 0 disables.
        (default 4)
    cache_timeout: How often we refresh this module in seconds (default 10)
    command: The program to use to change the backlight.
        Currently xbacklight and light are supported. The program needs
        to be installed and on your path. If no program is installed, this
        module will attempt to use logind support instead
        (default 'xbacklight')
    device: Device name or full path to use, eg, acpi_video0 or
        /sys/class/backlight/acpi_video0, otherwise automatic
        (default None)
    format: Display brightness, see placeholders below
        (default '☼: {level}%')
    hide_when_unavailable: Hide if no backlight is found
        (default False)
    low_tune_threshold: If current brightness value is below this threshold,
        the value is changed by a minimal value instead of the brightness_delta.
        (default 0)

Format placeholders:
    {level} brightness

Requires: one of
    xbacklight: need for changing brightness, not detection
    light: program to easily change brightness on backlight-controllers
    pydbus + logind v243: logind to change brightness without X

@author Tjaart van der Walt (github:tjaartvdwalt), Jérémy Rosen (github:boucman)
@license BSD
#################
# battery_level #
#################
Display battery information.

Configuration parameters:
    battery_id: id of the battery to be displayed
        set to 'all' for combined display of all batteries
        (default 0)
    blocks: a string, where each character represents battery level
        especially useful when using icon fonts (e.g. FontAwesome)
        (default "_▁▂▃▄▅▆▇█")
    cache_timeout: a timeout to refresh the battery state
        (default 60)
    charging_character: a character to represent charging battery
        especially useful when using icon fonts (e.g. FontAwesome)
        (default "⚡")
    format: string that formats the output. See placeholders below.
        (default "{icon}")
    format_notify_charging: format of the notification received when you click
        on the module while your computer is plugged in
        (default 'Charging ({percent}%)')
    format_notify_discharging: format of the notification received when you
        click on the module while your computer is not plugged in
        (default "{time_remaining}")
    hide_seconds: hide seconds in remaining time
        (default False)
    hide_when_full: hide any information when battery is fully charged (when
        the battery level is greater than or equal to 'threshold_full')
        (default False)
    measurement_mode: either 'acpi' or 'sys', or None to autodetect. 'sys'
        should be more robust and does not have any extra requirements, however
        the time measurement may not work in some cases
        (default None)
    notification: show current battery state as notification on click
        (default False)
    notify_low_level: display notification when battery is running low (when
        the battery level is less than 'threshold_degraded')
        (default False)
    on_udev_power_supply: dynamic variable to watch for `power_supply` udev subsystem
        events to trigger specified action.
        (default "refresh")
    sys_battery_path: set the path to your battery(ies), without including its
        number
        (default "/sys/class/power_supply/")
    threshold_bad: a percentage below which the battery level should be
        considered bad
        (default 10)
    threshold_degraded: a percentage below which the battery level should be
        considered degraded
        (default 30)
    threshold_full: a percentage at or above which the battery level should
        should be considered full
        (default 100)

Format placeholders:
    {ascii_bar} - a string of ascii characters representing the battery level,
        an alternative visualization to '{icon}' option
    {icon} - a character representing the battery level,
        as defined by the 'blocks' and 'charging_character' parameters
    {percent} - the remaining battery percentage (previously '{}')
    {time_remaining} - the remaining time until the battery is empty

Color options:
    color_bad: Battery level is below threshold_bad
    color_charging: Battery is charging (default "#FCE94F")
    color_degraded: Battery level is below threshold_degraded
    color_good: Battery level is above thresholds

Requires:
    - the `acpi` the acpi command line utility (only if
        `measurement_mode='acpi'`)

@author shadowprince, AdamBSteele, maximbaz, 4iar, m45t3r
@license Eclipse Public License
#################
# bitcoin_price #
#################
Display bitcoin using bitcoincharts.com.

Configuration parameters:
    cache_timeout: refresh interval for this module. A message from
        the site: Don't query more often than once every 15 minutes
        (default 900)
    color_index: Index of the market responsible for coloration,
    -1 means no coloration, except when only one market is selected
        (default -1)
    field: Field that is displayed per market,
        see https://bitcoincharts.com/about/markets-api/ (default 'close')
    format: display format for this module (default '{format_bitcoin}')
    format_bitcoin: display format for bitcoin (default '{market}: {price}{symbol}')
    format_separator: show separator if more than one (default ', ')
    hide_on_error: show error message (default False)
    markets: list of supported markets https://bitcoincharts.com/markets/list/
        (default 'btceUSD, btcdeEUR')
    symbols: if possible, convert currency abbreviations to symbols
        e.g. USD -&gt; $, EUR -&gt; € and so on (default True)

Format placeholders:
    {format_bitcoin} format for bitcoin

format_bitcoin placeholders:
    {market} market names
    {price} current prices
    {symbol} currency symbols

Color options:
    color_bad: Price has dropped or not available
    color_good: Price has increased

@author Andre Doser &lt;doser.andre AT gmail.com&gt;
#############
# bluetooth #
#############
Display bluetooth status.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default 'BT[: {format_device}]')
    format_device: display format for bluetooth devices (default '{name}')
    format_separator: show separator if more than one (default '\|')

Format placeholders:
    {format_device} format for bluetooth devices

format_device placeholders:
    {mac} bluetooth device address
    {name} bluetooth device name

Color options:
    color_bad: No connection
    color_good: Active connection

Requires:
    pydbus: pythonic dbus library

@author jmdana &lt;https://github.com/jmdana&gt;
@license GPLv3 &lt;https://www.gnu.org/licenses/gpl-3.0.txt&gt;
#############
# check_tcp #
#############
Display status of a TCP port on a given host.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{host}:{port} {state}')
    host: name of host to check for (default 'localhost')
    icon_off: show this when unavailable (default 'DOWN')
    icon_on: show this when available (default 'UP')
    port: number of port to check for (default 22)

Format placeholders:
    {state} port state

Color options:
    color_down: Closed, default to color_bad
    color_up: Open, default to color_good

@author obb, Moritz Lüdecke
##############
# clementine #
##############
Display song currently playing in Clementine.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module (default '♫ {current}')

Format placeholders:
    {current} currently playing

Requires:
    clementine: a modern music player and library organizer
    qdbus: a communication-interface for qt-based applications
        (may be part of qt5-tools)

@author Francois LASSERRE &lt;choiz@me.com&gt;
@license GNU GPL https://www.gnu.org/licenses/gpl.html
#########
# clock #
#########
Display date and time.

This module allows one or more datetimes to be displayed.
All datetimes share the same format_time but can set their own timezones.
Timezones are defined in the `format` using the TZ name in squiggly brackets eg
`{GMT}`, `{Portugal}`, `{Europe/Paris}`, `{America/Argentina/Buenos_Aires}`.

ISO-3166 two letter country codes eg `{de}` can also be used but if more than
one timezone exists for the country eg `{us}` the first one will be selected.

`{Local}` can be used for the local settings of your computer.

Note: Timezones are case sensitive

A full list of timezones can be found at
https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

Configuration parameters:
    block_hours: length of time period for all blocks in hours (default 12)
    blocks: a string, where each character represents time period
        from the start of a time period.
        (default '🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦')
    button_change_format: button that switches format used setting to None
        disables (default 1)
    button_change_time_format: button that switches format_time used. Setting
        to None disables (default 2)
    button_reset: button that switches display to the first timezone. Setting
        to None disables (default 3)
    cycle: If more than one display then how many seconds between changing the
        display (default 0)
    format: defines the timezones displayed. This can be a single string or a
        list.  If a list is supplied then the formats can be cycled through
        using `cycle` or by button click.  (default '{Local}')
    format_time: format to use for the time, strftime directives such as `%H`
        can be used this can be either a string or to allow multiple formats as
        a list.  The one used can be changed by button click.
        *(default ['[{name_unclear} ]%c', '[{name_unclear} ]%x %X',
        '[{name_unclear} ]%a %H:%M', '[{name_unclear} ]{icon}'])*
    locale: Override the system locale. Examples:
        when set to 'fr_FR' %a on Tuesday is 'mar.'.
        (default None)
    round_to_nearest_block: defines how a block icon is chosen. Examples:
        when set to True,  '13:14' is '🕐', '13:16' is '🕜' and '13:31' is '🕜';
        when set to False, '13:14' is '🕐', '13:16' is '🕐' and '13:31' is '🕜'.
        (default True)

Format placeholders:
    {icon} a character representing the time from `blocks`
    {name} friendly timezone name eg `Buenos Aires`
    {name_unclear} friendly timezone name eg `Buenos Aires` but is empty if
        only one timezone is provided
    {timezone} full timezone name eg `America/Argentina/Buenos_Aires`
    {timezone_unclear} full timezone name eg `America/Argentina/Buenos_Aires`
        but is empty if only one timezone is provided

Requires:
    pytz: cross platform time zone library for python
    tzlocal: tzinfo object for the local timezone

Examples:
```
# cycling through London, Warsaw, Tokyo
clock {
    cycle = 30
    format = ["{Europe/London}", "{Europe/Warsaw}", "{Asia/Tokyo}"]
    format_time = "{name} %H:%M"
}

# Show the time and date in New York
clock {
   format = "Big Apple {America/New_York}"
   format_time = "%Y-%m-%d %H:%M:%S"
}

# wall clocks
clock {
    format = "{Asia/Calcutta} {Africa/Nairobi} {Asia/Bangkok}"
    format_time = "{name} {icon}"
}
```

@author tobes
@license BSD
########
# cmus #
########
Display song currently playing in cmus.

cmus (C* Music Player) is a small, fast and powerful console audio player
which supports most major audio formats. Various features include gapless
playback, ReplayGain support, MP3 and Ogg streaming, live filtering, instant
startup, customizable key-bindings, and vi-style default key-bindings.

Configuration parameters:
    button_next: mouse button to skip next track (default None)
    button_pause: mouse button to pause/play the playback (default 1)
    button_previous: mouse button to skip previous track (default None)
    button_stop: mouse button to stop the playback (default 3)
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module
        *(default '[\?if=is_started [\?if=is_playing &gt; ][\?if=is_paused \|\| ]'
        '[\?if=is_stopped .. ][[{artist}][\?soft  - ][{title}]'
        '|\?show cmus: waiting for user input]]')*
    sleep_timeout: sleep interval for this module. when cmus is not running,
        this interval will be used. this allows some flexible timing where one
        might want to refresh constantly with some placeholders... or to refresh
        only once every minute rather than every few seconds. (default 20)

Control placeholders:
    {is_paused} a boolean based on cmus status
    {is_playing} a boolean based on cmus status
    {is_started} a boolean based on cmus status
    {is_stopped} a boolean based on cmus status
    {continue} a boolean based on data status
    {play_library} a boolean based on data status
    {play_sorted} a boolean based on data status
    {repeat} a boolean based on data status
    {repeat_current} a boolean based on data status
    {replaygain} a boolean based on data status
    {replaygain_limit} a boolean based on data status
    {shuffle} a boolean based on data status
    {softvol} a boolean based on data status
    {stream} a boolean based on data status

Format placeholders:
    {aaa_mode} shuffle mode, eg artist, album, all
    {albumartist} album artist, eg (new output here)
    {album} album name, eg (new output here)
    {artist} artist name, eg (new output here)
    {bitrate} audio bitrate, eg 229
    {comment} comment, eg URL
    {date} year number, eg 2015
    {duration} length time in seconds, eg 171
    {durationtime} length time in [HH:]MM:SS, eg 02:51
    {file} file location, eg /home/user/Music...
    {position} elapsed time in seconds, eg 17
    {positiontime} elapsed time in [HH:]MM:SS, eg 00:17
    {replaygain_preamp} replay gain preamp, eg 0.000000
    {status} playback status, eg playing, paused, stopped
    {title} track title, eg (new output here)
    {tracknumber} track number, eg 0
    {vol_left} left volume number, eg 90
    {vol_right} right volume number, eg 90

    Placeholders are retrieved directly from `cmus-remote --query` command.
    The list was harvested only once and should not represent a full list.

Color options:
    color_paused: Paused, defaults to color_degraded
    color_playing: Playing, defaults to color_good
    color_stopped: Stopped, defaults to color_bad

Requires:
    cmus: a small feature-rich ncurses-based music player

@author lasers
################
# coin_balance #
################
Display balances of diverse crypto-currencies.

This module grabs your current balance of different crypto-currents from a
wallet server. The server must conform to the bitcoin RPC specification.
Currently Bitcoin, Dogecoin, and Litecoin are supported.

Configuration parameters:
    cache_timeout: An integer specifying the cache life-time of the output in
        seconds (default 30)
    coin_password: A string containing the password for the server for
        'coin'. The 'coin' part must be replaced by a supported coin identifier
        (see below for a list of identifiers). If no value is supplied,
        the value of 'password' (see below) will be used.  If 'password' too is
        not set, the value will be retrieved from the standard 'coin' daemon
        configuration file. (default None)
    coin_username: A string containing the username for the server for
        'coin'. The 'coin' part must be replaced by a supported coin identifier
        (see below for a list of identifiers). If no value is supplied,
        the value of 'username' (see below) will be used.  If 'username' too is
        not set, the value will be retrieved from the standard 'coin' daemon
        configuration file. (default None)
    credentials: (default None)
    format: A string describing the output format for the module. The {<coin>}
        placeholder (see below) will be used to determine how to fetch the
        coin balance. Multiple placeholders are allowed, but all balances will
        be fetched from the same host. (default 'LTC: {litecoin}')
    host: The coin-server hostname. Note that all coins will use the same host
        for their queries. (default 'localhost')
    password: A string containing the password for all coin-servers. If neither
        this setting, nor a specific coin_password (see above) is specified,
        the password for each coin will be read from the respective standard
        daemon configuration file. (default None)
    protocol: A string to select the server communication protocol.
        (default 'http')
    username: A string containing the username for all coin-servers. If neither
        this setting, nor a specific coin_username (see above) is specified,
        the username for each coin will be read from the respective standard
        daemon configuration file. (default None)

Format placeholders:
    {<coin>} Your balance for the coin <coin&gt; where &lt;coin> is one of:
    - bitcoin
    - dogecoin
    - litecoin

Requires:
    requests: python module from pypi https://pypi.python.org/pypi/requests
        At least version 2.4.2 is required.

Examples:
```
# Get your Bitcoin balance using automatic credential detection
coin_balance {
    cache_timeout = 45
    format = "My BTC: {bitcoin}"
    host = "localhost"
    protocol = "http"
}

# Get your Bitcoin, Dogecoin and Litecoin balances using specific credentials
# for Bitcoin and automatic detection for Dogecoin and Litecoin
coin_balance {
    # ...
    format = "{bitcoin} BTC {dogecoin} XDG {litecoin} LTC"
    bitcoin_username = "lcdata"
    bitcoin_password = "omikron-theta"
    # ...
}

# Get your Dogecoin and Litecoin balances using 'global' credentials
coin_balance {
    # ...
    format = "XDG: {dogecoin} LTC: {litecoin}"
    username = "crusher_b"
    password = "WezRulez"
    # ...
}

# Get you Dogecoin, Litecoin, and Bitcoin balances by using 'global'
# credentials for Bitcoin and Dogecoin but specific credentials for
# Litecoin.
coin_balance {
    # ...
    format = "XDG: {dogecoin} LTC: {litecoin} BTC: {bitcoin}"
    username = "zcochrane"
    password = "sunny_islands"
    litecoin_username = 'locutus'
    litecoin_password = 'NCC-1791-D'
    # ...
}
```

@author Felix Morgner &lt;felix.morgner@gmail.com&gt;
@license 3-clause-BSD
###############
# coin_market #
###############
Display cryptocurrency coins.

The site offer various types of data such as name, symbol, price, volume,
total supply, et cetera for a wide range of cryptocurrencies and the prices
can be obtained in a different currency along with optional USD currency.
For more information, visit https://coinmarketcap.com

Configuration parameters:
    cache_timeout: refresh interval for this module. a message from the site:
        please limit requests to no more than 10 per minute. (default 600)
    format: display format for this module (default '{format_coin}')
    format_coin: display format for coins
        *(default '{name} ${price_usd:.2f} '
        '[\?color=percent_change_24h {percent_change_24h}%]')*
    format_datetime: specify strftime characters to format (default {})
    format_separator: show separator if more than one (default ' ')
    markets: number of top-ranked markets or list of user-inputted markets
        (default ['btc'])
    thresholds: specify color thresholds to use
        (default [(-100, 'bad'), (0, 'good')])

Format placeholders:
    {format_coin} format for cryptocurrency coins

format_datetime placeholders:
    key: epoch_placeholder, eg last_updated
    value: % strftime characters to be translated, eg '%b %d' ----&gt; 'Nov 29'

format_coin placeholders:
    {id}                 eg bitcoin
    {name}               eg Bitcoin
    {symbol}             eg BTC
    {rank}               eg 1
    {price_usd}          eg 11163.4
    {price_btc}          eg 1.0
    {24h_volume_usd}     eg 10156700000.0
    {market_cap_usd}     eg 186528134260
    {available_supply}   eg 16708900.0
    {total_supply}       eg 16708900.0
    {max_supply}         eg 21000000.0
    {percent_change_1h}  eg 0.92
    {percent_change_24h} eg 11.2
    {percent_change_7d}  eg 35.96
    {last_updated}       eg 151197295

    Placeholders are retrieved directly from the URL.
    The list was harvested once and should not represent a full list.

    To print coins in different currency, replace or replicate the placeholders
    below with a valid option (eg '{price_gbp}') to create additional placeholders:

    {price_xxx}           eg (new output here)
    {24h_volume_xxx}      eg (new output here)
    {market_cap_xxx}      eg (new output here)

    Valid options are: AUD, BRL, CAD, CHF, CNY, EUR, GBP, HKD, IDR, INR,
    JPY, KRW, MXN, RUB, otherwise USD... and be written in lowercase.

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Examples:
```
# view coins in GBP and optionally USD
coin_market {
    format_coin = '{name} £{price_gbp:.2f} ${price_usd:.2f} {percent_change_24h}'
}

# display top five markets
coin_market {
    markets = 5
}

# colorize market names
coin_market {
    format_coin = "[\?color=name {name}] ${price_usd:.2f} "
    format_coin += "[\?color=percent_change_24h {percent_change_24h}%]"
    markets = ["btc", "eth", "ltc", "doge"]
    thresholds = {
        "name": [
            ("Bitcoin", "greenyellow"),
            ("Ethereum", "deepskyblue"),
            ("Litecoin", "crimson"),
            ("Dogecoin", "orange"),
        ],
        "percent_change_24h": [(-100, "bad"), (0, "good")],
    }
}

# show and/or customize last_updated time
coin_market {
    format_coin = '{name} ${price_usd:.2f} '
    format_coin += '[\?color=percent_change_24h {percent_change_24h}%] {last_updated}'
    format_datetime = {'last_updated': '\?color=degraded last updated %-I:%M%P'}
}
```

@author lasers, x86kernel
#########
# conky #
#########
Display Conky objects/variables on the bar.

Configuration parameters:
    config: specify configuration settings for conky (default {})
    format: display format for this module (default None)
    thresholds: specify color thresholds to use (default [])

Format placeholders:
        According to man page, Conky has more than 250 built-in objects/variables.

    See `man -P 'less -p OBJECTS/VARIABLES' conky` for a full list of Conky
    objects/variables to use. Not all of Conky objects/variables will be
    supported or usable.

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder
        Replace spaces with periods.

Examples:
```
# add conky config options
# See `man -P "less -p 'CONFIGURATION SETTINGS'" conky` for a full list
# of Conky configuration options. Not all of Conky configuration options
# will be supported or usable.
conky {
    config = {
        'update_interval': 10             # update interval for conky
        'update_interval_on_battery': 60  # update interval when on battery
        'format_human_readable': True,    # if False, print in bytes
        'short_units': True,              # shortens units, eg kiB->k, GiB->G
        'uppercase': True,                # upper placeholders
    }
}

# display ip address
order += "conky addr"
conky addr {
    format = 'IP [\?color=orange {addr eno1}]'
}

# display load averages
order += "conky loadavg"
conky loadavg {
    format = 'Loadavg '
    format += '[\?color=lightgreen {loadavg 1} ]'
    format += '[\?color=lightgreen {loadavg 2} ]'
    format += '[\?color=lightgreen {loadavg 3}]'
}

# exec commands at different intervals, eg 5s, 60s, and 3600s
order += "conky date"
conky date {
    format = 'Exec '
    format += '[\?color=good {execi 5 "date"}] '
    format += '[\?color=degraded {execi 60 "uptime -p"}] '
    format += '[\?color=bad {execi 3600 "uptime -s"}]'
}

# display diskio read, write, etc
order += "conky diskio"
conky diskio {
    format = 'Disk IO [\?color=darkgray&show sda] '
    format += '[\?color=lightskyblue '
    format += '{diskio_read sda}/{diskio_write sda} '
    format += '({diskio sda})]'

    # format += ' '
    # format += '[\?color=darkgray&show sdb] '
    # format += '[\?color=lightskyblue '
    # format += '{diskio_read sdb}/{diskio_write sdb} '
    # format += '({diskio sdb})]'
    config = {'short_units': True}
}

# display total number of processes and running processes
order += "conky proc"
conky proc {
    format = 'Processes [\?color=cyan {processes}/{running_processes}]'
}

# display top 3 cpu (+mem_res) processes
order += "conky top_cpu" {
conky top_cpu {
    format = 'Top [\?color=darkgray '
    format += '{top name 1} '
    format += '[\?color=deepskyblue {top mem_res 1}] '
    format += '[\?color=lightskyblue {top cpu 1}%] '

    format += '{top name 2} '
    format += '[\?color=deepskyblue {top mem_res 2}] '
    format += '[\?color=lightskyblue {top cpu 2}%] '

    format += '{top name 3} '
    format += '[\?color=deepskyblue {top mem_res 3}] '
    format += '[\?color=lightskyblue {top cpu 3}%]]'
    config = {'short_units': True}
}

# display top 3 memory processes
order += "conky top_mem"
conky top_mem {
    format = 'Top Mem [\?color=darkgray '
    format += '{top_mem name 1} '
    format += '[\?color=yellowgreen {top_mem mem_res 1}] '
    format += '[\?color=lightgreen {top_mem mem 1}%] '

    format += '{top_mem name 2} '
    format += '[\?color=yellowgreen {top_mem mem_res 2}] '
    format += '[\?color=lightgreen {top_mem mem 2}%] '

    format += '{top_mem name 3} '
    format += '[\?color=yellowgreen {top_mem mem_res 3}] '
    format += '[\?color=lightgreen {top_mem mem 3}%]]'
    config = {'short_units': True}
}

# display memory, memperc, membar + thresholds
order += "conky memory"
conky memory {
    format = 'Memory [\?color=lightskyblue {mem}/{memmax}] '
    format += '[\?color=memperc {memperc}% \[{membar}\]]'
    thresholds = [
        (0, 'darkgray'), (0.001, 'good'), (50, 'degraded'),
        (75, 'orange'), (85, 'bad')
    ]
}

# display swap, swapperc, swapbar + thresholds
order += "conky swap"
conky swap {
    format = 'Swap [\?color=lightcoral {swap}/{swapmax}] '
    format += '[\?color=swapperc {swapperc}% \[{swapbar}\]]'
    thresholds = [
        (0, 'darkgray'), (0.001, 'good'), (50, 'degraded'),
        (75, 'orange'), (85, 'bad')
    ]
}

# display up/down speed and up/down total
order += "conky network"
conky network {
    format = 'Speed [\?color=title {upspeed eno1}/{downspeed eno1}] '
    format += 'Total [\?color=title {totalup eno1}/{totaldown eno1}]'
    color_title = '#ff6699'
}

# display file systems + thresholds
order += "conky filesystem"
conky filesystem {
    # home filesystem
    format = 'Home [\?color=violet {fs_used /home}/{fs_size /home} '
    format += '[\?color=fs_used_perc./home '
    format += '{fs_used_perc /home}% \[{fs_bar /home}\]]]'

    # hdd filesystem
    # format += ' HDD [\?color=violet {fs_used '
    # format += '/run/media/user/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    # format += '}/{fs_size '
    # format += '/run/media/user/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    # format += '}[\?color=fs_used_perc.'
    # format += '/run/media/user/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    # format += ' {fs_used_perc '
    # format += '/run/media/user/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    # format += '}% \[{fs_bar '
    # format += '/run/media/user/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    # format += '}\]]]'

    thresholds = [
        (0, 'darkgray'), (0.001, 'good'), (50, 'degraded'),
        (75, 'orange'), (85, 'bad')
    ]
}

# show cpu percents/bars + thresholds
order += "conky cpu"
conky cpu {
    format = 'CPU '
    format += '[\?color=cpu.cpu0 {cpu cpu0}% {cpubar cpu0}] '
    format += '[\?color=cpu.cpu1 {cpu cpu1}% {cpubar cpu1}] '
    format += '[\?color=cpu.cpu2 {cpu cpu2}% {cpubar cpu2}] '
    format += '[\?color=cpu.cpu3 {cpu cpu3}% {cpubar cpu3}]'

    thresholds = [
        (0, 'darkgray'), (0.001, 'good'), (50, 'degraded'),
        (75, 'orange'), (85, 'bad')
    ]
}

# show more examples, many outputs
order += "conky info"
conky info {
    format = '[\?color=title&show OS] [\?color=output {distribution}] '
    format += '[\?color=title&show CPU] [\?color=output {cpu cpu0}%] '
    format += '[\?color=title&show MEM] '
    format += '[\?color=output {mem}/{memmax} ({memperc}%)] '
    format += '[\?color=title&show HDD] [\?color=output {fs_used_perc}%] '
    format += '[\?color=title&show Kernel] [\?color=output {kernel}] '
    format += '[\?color=title&show Loadavg] [\?color=output {loadavg 1}] '
    format += '[\?color=title&show Uptime] [\?color=output {uptime}] '
    format += '[\?color=title&show Freq GHZ] [\?color=output {freq_g}]'
    color_title = '#ffffff'
    color_output = '#00bfff'
}

# change console bars - shoutout to su8 for adding this
conky {
    config = {
        'console_bar_fill': "'#'",
        'console_bar_unfill': "'_'",
        'default_bar_width': 10,
    }
}

# display nvidia stats - shoutout to brndnmtthws for fixing this
# See `man -P 'less -p nvidia\ argument' conky` for more nvidia variables.
order += "conky nvidia"
conky nvidia {
    format = 'GPU Temp [\?color=greenyellow {nvidia temp}] '
    format += 'GPU Freq [\?color=greenyellow {nvidia gpufreq}] '
    format += 'Mem Freq [\?color=greenyellow {nvidia memfreq}] '
    format += 'MTR Freq [\?color=greenyellow {nvidia mtrfreq}] '
    format += 'Perf [\?color=greenyellow {nvidia perflevel}] '
    format += 'Mem Perc [\?color=greenyellow {nvidia memperc}]'
    config = {
        'nvidia_display': "':0'"
    }
}
```

@author lasers
############
# deadbeef #
############
Display songs currently playing in DeaDBeeF.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module (default '[{artist} - ][{title}]')
    sleep_timeout: when deadbeef is not running, this interval will be used
        to allow faster refreshes with time-related placeholders and/or
        to refresh few times per minute rather than every few seconds
        (default 20)

Format placeholders:
    {album} name of the album
    {artist} name of the artist
    {length} length time in [HH:]MM:SS
    {playback_time} elapsed time in [HH:]MM:SS
    {title} title of the track
    {tracknumber} track number in two digits
    {year} year in four digits

    For more placeholders, see title formatting 2.0 in 'deadbeef --help'
    or https://github.com/DeaDBeeF-Player/deadbeef/wiki/Title-formatting-2.0
    Not all of Foobar2000 remapped metadata fields will work with deadbeef and
    a quick reminder about using {placeholders} here instead of %placeholder%.

Color options:
    color_paused: Paused, defaults to color_degraded
    color_playing: Playing, defaults to color_good
    color_stopped: Stopped, defaults to color_bad

Requires:
    deadbeef: a GTK+ audio player for GNU/Linux

Examples:
```
# see 'deadbeef --help' for more buttons
deadbeef {
    on_click 1 = 'exec deadbeef --play-pause'
    on_click 8 = 'exec deadbeef --random'
}
```

@author mrt-prodz
############
# diskdata #
############
Display disk information.

Configuration parameters:
    cache_timeout: refresh interval for this module. (default 10)
    disk: show stats for disk or partition, i.e. `sda1`. None for all disks.
        (default None)
    format: display format for this module.
        (default "{disk}: {used_percent}% ({total})")
    format_rate: display format for rates value
        (default "[\?min_length=11 {value:.1f} {unit}]")
    format_space: display format for disk space values
        (default "[\?min_length=5 {value:.1f}]")
    sector_size: size of the disk's sectors.
        (default 512)
    si_units: use SI units
        (default False)
    thresholds: specify color thresholds to use
        *(default {'free': [(0, 'bad'), (10, 'degraded'), (100, 'good')],
        'total': [(0, 'good'), (1024, 'degraded'), (1024 * 1024, 'bad')],
        'used_percent': [(0, 'good'), (40, 'degraded'), (75, 'bad')]})*
    unit: unit to use. If the unit contains a multiplier prefix, only this
        exact unit will ever be used
        (default "B/s")

Format placeholders:
    {disk} the selected disk
    {free} free space on disk in GB
    {used} used space on disk in GB
    {total_space} total space on disk in GB
    {used_percent} used space on disk in %
    {read} reading rate
    {total} total IO rate
    {write} writing rate

format_rate placeholders:
    {unit} name of the unit
    {value} numeric value of the rate

format_space placeholders:
    {value} numeric value of the free/used space on the device

Color thresholds:
    {free} Change color based on the value of free
    {used} Change color based on the value of used
    {used_percent} Change color based on the value of used_percent
    {read} Change color based on the value of read
    {total} Change color based on the value of total
    {write} Change color based on the value of write

@author guiniol
@license BSD
##################
# do_not_disturb #
##################
Turn on and off desktop notifications.

Configuration parameters:
    cache_timeout: refresh interval for this module; for xfce4-notifyd
        (default 30)
    format: display format for this module
        (default '{name} [\?color=state&amp;show DND]')
    pause: specify whether to pause or kill processes; for dunst
        see `Dunst Miscellaneous` section for more information
        (default False)
    server: specify server to use, eg mako, dunst or xfce4-notifyd, otherwise auto
        (default None)
    state: specify state to use on startup, otherwise last
        False: disable Do Not Disturb on startup
        True: enable Do Not Disturb on startup
        last: toggle last known state on startup
        None: query current state from notification manager (doesn't work on dunst)
        (default 'last')
    thresholds: specify color thresholds to use
        (default [(0, 'bad'), (1, 'good')])

Format placeholders:
    {name} name, eg Mako, Dunst, Xfce4-notifyd
    {state} do not disturb state, eg 0, 1

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Dunst Miscellaneous:
        When paused, dunst will not display any notifications but keep all
        notifications in a queue. This can for example be wrapped around a screen
        locker (i3lock, slock) to prevent flickering of notifications through the
        lock and to read all missed notifications after returning to the computer.
        This means that by default (pause = False), all notifications sent while
        DND is active will NOT be queued and displayed when DND is deactivated.


Examples:
```
# display ON/OFF
do_not_disturb {
    format = '{name} [\?color=state [\?if=state  ON|OFF]]'
}

# display 1/0
do_not_disturb {
    format = '{name} [\?color=state {state}]'
}

# display DO NOT DISTURB/DISTURB
do_not_disturb {
    format = '[\?color=state [\?if=state DO NOT DISTURB|DISTURB]]'
    thresholds = [(0, "darkgray"), (1, "good")]
}
```

@author Maxim Baz https://github.com/maximbaz (dunst)
@author Robert Ricci https://github.com/ricci (xfce4-notifyd)
@author Cyrinux https://github.com/cyrinux (mako)
@license BSD
########
# dpms #
########
Turn on and off DPMS and screen saver blanking.

Configuration parameters:
    button_off: mouse button to turn off screen (default None)
    button_toggle: mouse button to toggle DPMS (default 1)
    cache_timeout: refresh interval for this module (default 15)
    format: display format for this module (default '{icon}')
    icon_off: show when DPMS is disabled (default 'DPMS')
    icon_on: show when DPMS is enabled (default 'DPMS')

Format placeholders:
    {icon} DPMS icon

Color options:
    color_on: Enabled, defaults to color_good
    color_off: Disabled, defaults to color_bad

@author Andre Doser &lt;dosera AT tf.uni-freiburg.de&gt;
###################
# dropboxd_status #
###################
Display status of Dropbox daemon.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default "Dropbox: {status}")
    status_busy: text for placeholder {status} when Dropbox is busy
        (default None)
    status_off: text for placeholder {status} when Dropbox isn't running
        (default "isn't running")
    status_on: text for placeholder {status} when Dropbox is up to date
        (default "Up to date")

Value for `status_off` if not set:
    - Dropbox isn't running!

Value for `status_on` if not set:
    - Up to date

Values for `status_busy` if not set:
    - Connecting...
    - Starting...
    - Downloading file list...
    - Syncing "filename"

Format placeholders:
    {status} Dropbox status

Color options:
    color_bad: Not running
    color_degraded: Busy
    color_good: Up to date

Requires:
    dropbox-cli: command line interface for dropbox

Notes:
        Some distributions offer an option to install dropbox-cli. If you don't see
        one for your distribution, then you need to download CLI Python script,
        https://www.dropbox.com/help/desktop-web/linux-commands#commands, rename
        it to `dropbox-cli`, make the script executable and available in your PATH.

@author Tjaart van der Walt (github:tjaartvdwalt)
@license BSD
#################
# emerge_status #
#################
Display information about the currently running emerge process.

Configuration parameters:
    cache_timeout: how often we refresh this module in second.
        NOTE: when emerge is running, we will refresh this module every second.
        (default 30)
    emerge_log_file: path to the emerge log file.
        (default '/var/log/emerge.log')
    format: display format for this module
        *(default '{prefix}[\?if=is_running : [\?if=!total=0 '
        '[{current}/{total} {action} {category}/{pkg}]'
        '|calculating...]|: stopped 0/0]')*
    prefix: prefix in statusbar
        (default "emrg")

Format placeholders:
    {action} current emerge action
    {category} category of the currently emerged package
    {current} number of package that is currently emerged
    {pkg} name of the currently emerged packaged
    {total} total number of packages that will be emerged

Examples:
```
# Hide if not running
emerge_status {
    format = "[\?if=is_running {prefix}: [\?if=!total=0 "
    format += "{current}/{total} {action} {category}/{pkg}"
    format += "|calculating...]]"
}

# Minimalistic
emerge_status {
    format = "[\?if=is_running [\?if=!total=0 {current}/{total}]]"
}

# Minimalistic II
emerge_status {
    format = "[\?if=is_running {current}/{total}]"
}
```

@author AnwariasEu
#################
# exchange_rate #
#################
Display foreign exchange rates.

Configuration parameters:
    base: specify base currency to use for exchange rates (default 'EUR')
    cache_timeout: refresh interval for this module (default 600)
    format: display format for this module (default '${USD} £{GBP} ¥{JPY}')

Format placeholders:
        See https://api.exchangeratesapi.io/latest for a full list of foreign
        exchange rates published by the European Central Bank. Not all of exchange
        rates will be available. Also, see https://en.wikipedia.org/wiki/ISO_4217

@author tobes
@license BSD
###################
# external_script #
###################
Display output of a given script.

Display output of any executable script set by `script_path`. Only the first
two lines of output will be used. The first line is used as the displayed
text. If the output has two or more lines, the second line is set as the text
color (and should hence be a valid hex color code such as #FF0000 for red).
The script should not have any parameters, but it could work.

Configuration parameters:
    button_show_notification: button to show notification with full output
        (default None)
    cache_timeout: how often we refresh this module in seconds
        (default 15)
    format: see placeholders below (default '{output}')
    localize: should script output be localized (if available)
        (default True)
    script_path: script you want to show output of (compulsory)
        (default None)
    strip_output: shall we strip leading and trailing spaces from output
        (default False)

Format placeholders:
    {lines} number of lines in the output
    {output} output of script given by "script_path"

Examples:
```
external_script {
    format = "my name is {output}"
    script_path = "/usr/bin/whoami"
}
```

@author frimdo ztracenastopa@centrum.cz
##################
# fedora_updates #
##################
Display number of pending updates for Fedora Linux.

This will display a count of how many `dnf` updates are waiting
to be installed. Additionally check for update security notices.

Configuration parameters:
    cache_timeout: How often we refresh this module in seconds
        (default 600)
    check_security: Check for security updates
        (default True)
    format: Display format to use
        (default 'DNF: {updates}')

Format placeholders:
    {updates} number of pending dnf updates

Color options:
    color_bad: Security notice
    color_degraded: Upgrade available
    color_good: No upgrades needed

@author tobes
@license BSD
###############
# file_status #
###############
Display if files or directories exists.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module
        (default '\?color=path [\?if=path ●|■]')
    format_path: format for paths (default '{basename}')
    format_path_separator: show separator if more than one (default ' ')
    paths: specify a string or a list of paths to check (default None)
    thresholds: specify color thresholds to use
        (default [(0, 'bad'), (1, 'good')])

Format placeholders:
    {format_path} format for paths
    {path} number of paths, eg 1, 2, 3

format_path placeholders:
    {basename} basename of pathname
    {pathname} pathname

Color options:
    color_bad: files or directories does not exist
    color_good: files or directories exists

Color thresholds:
    format:
        path: print a color based on the number of paths

Examples:
```
# add multiple paths with wildcard or with pathnames
file_status {
    paths = ['/tmp/test*', '~user/test1', '~/Videos/*.mp4']
}

# colorize basenames
file_status {
    paths = ['~/.config/i3/modules/*.py']
    format = '{format_path}'
    format_path = '\?color=good {basename}'
    format_path_separator = ', '
}
```

@author obb, Moritz Lüdecke, Cyril Levis (@cyrinux)
#########
# frame #
#########
Group modules and treat them as a single one.

This can be useful for example when adding modules to a group and you wish two
modules to be shown at the same time.

By adding the `{button}` placeholder in the format you can enable a toggle
button to hide or show the content.

Configuration parameters:
    button_toggle: Button used to toggle if one in format.
        Setting to None disables (default 1)
    format: Display format to use (default '{output}')
    format_button_closed: Format for the button when frame open (default '+')
    format_button_open: Format for the button when frame closed (default '-')
    format_separator: Specify separator between contents.
        If this is None then the default i3bar separator will be used
        (default None)
    open: If button then the frame can be set to be open or close
        (default True)

Format placeholders:
    {button} If used a button will be used that can be clicked to hide/show
        the contents of the frame.
    {output} The output of the modules in the frame
    {output_xxx} The output of the module xxx (even if the button is currently
        toggled off).

Examples:
```
# A frame showing times in different cities.
# We also have a button to hide/show the content
frame time {
    format = '{output}{button}'
    format_separator = ' '  # have space instead of usual i3bar separator

    tztime la {
        format = "LA %H:%M"
        timezone = "America/Los_Angeles"
    }
    tztime ny {
        format = "NY %H:%M"
        timezone = "America/New_York"
    }
    tztime du {
        format = "DU %H:%M"
        timezone = "Asia/Dubai"
    }
}

# Define a group which shows volume and battery info or the current time.
# The frame, volume_status and battery_level modules are named to prevent
# them clashing with any other defined modules of the same type.
group {
    frame {
        volume_status {}
        battery_level {}
    }
    time {}
}

# Define a group where the button is colored only if sub module has some output
frame ipv6 {
    format = "[\?if=output_ipv6 {output}{button}|\?color=#bad {output}{button}]"
    open = false

    ipv6 {
        format_up = "%ip"
        format_down = ""
    }
}
```

@author tobes
###########
# getjson #
###########
Display JSON data fetched from a URL.

This module gets the given `url` configuration parameter and assumes the
response is a JSON object. The keys of the JSON object are used as the format
placeholders. The format placeholders are replaced by the value. Objects that
are nested can be accessed by using the `delimiter` configuration parameter
in between.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 30)
    delimiter: the delimiter between parent and child objects (default '-')
    format: display format for this module (default None)
    password: basic auth password information (default None)
    url: specify URL to fetch JSON from (default None)
    username: basic auth user information (default None)

Format placeholders:
        Placeholders will be replaced by the JSON keys.

    Placeholders for objects with sub-objects are flattened using 'delimiter'
    in between (eg. {'parent': {'child': 'value'}} will use placeholder
    {parent-child}).

    Placeholders for list elements have 'delimiter' followed by the index
    (eg. {'parent': ['this', 'that']) will use placeholders {parent-0}
    for 'this' and {parent-1} for 'that'.

Examples:
```
# straightforward key replacement
url = 'http://ip-api.com/json'
format = '{lat}, {lon}'

# access child objects
url = 'https://api.icndb.com/jokes/random'
format = '{value-joke}'

# access title from 0th element of articles list
url = 'https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey={KEY}'
format = '{articles-0-title}'

# access if top-level object is a list
url = 'https://jsonplaceholder.typicode.com/posts/1/comments'
format = '{0-name}'
```

@author vicyap
##########
# github #
##########
Display Github notifications and issue/pull requests for a repo.

To check notifications a Github `username` and `personal access token` are
required.  You can create a personal access token at
https://github.com/settings/tokens/new?scopes=notifications&amp;description=py3status
The only `scope` needed is `notifications` is selected automatically for you,
which provides readonly access to notifications.

The Github API is rate limited so setting `cache_timeout` too small may cause
issues see https://developer.github.com/v3/#rate-limiting for details

Configuration parameters:
    auth_token: Github personal access token, needed to check notifications
        see above.
        (default None)
    button_action: Button that when clicked opens the Github notification page
        if notifications, else the project page for the repository if there is
        one (otherwise the github home page). Setting to `None` disables.
        (default 3)
    button_refresh: Button that when clicked refreshes module.
        Setting to `None` disables.
        (default 2)
    cache_timeout: How often we refresh this module in seconds
        (default 60)
    format: display format for this module, see Examples below (default None)
    format_notifications: Format of `{notification}` status placeholder.
        (default ' N{notifications_count}')
    notifications: Type of notifications can be `all` for all notifications or
        `repo` to only get notifications for the repo specified.  If repo is
        not provided then all notifications will be checked.
        (default 'all')
    repo: Github repo to check
        (default 'ultrabug/py3status')
    url_api: Change only if using Enterprise Github, example https://github.domain.com/api/v3.
        (default 'https://api.github.com')
    url_base: Change only if using Enterprise Github, example https://github.domain.com.
        (default 'https://github.com')
    username: Github username, needed to check notifications.
        (default None)

Format placeholders:
    {issues} Number of open issues.
    {notifications} Notifications.  If no notifications this will be empty.
    {notifications_count} Number of notifications.  This is also the __Only__
        placeholder available to `format_notifications`.
    {pull_requests} Number of open pull requests
    {repo} short name of the repository being checked. eg py3status
    {repo_full} full name of the repository being checked. eg ultrabug/py3status

Examples:
```
# default formats
github {
    # with username and auth_token, this will be used
    format = '{repo} {issues}/{pull_requests}{notifications}'

    # otherwise, this will be used
    format '{repo} {issues}/{pull_requests}'
}

# set github access credentials
github {
    auth_token = '40_char_hex_access_token'
    username = 'my_username'
}

# just check for any notifications
github {
    auth_token = '40_char_hex_access_token'
    username = 'my_username'
    format = 'Github {notifications_count}'
}
```

@author tobes
##########
# gitlab #
##########
Display number of issues, requests and more from a GitLab project.

A token is required. See https://gitlab.com/profile/personal_access_tokens
to make one. Make a name, eg py3status, and enable api in scopes. Save.

Configuration parameters:
    auth_token: specify a personal access token to use (default None)
    button_open: mouse button to open project url (default 1)
    button_refresh: mouse button to refresh this module (default 2)
    cache_timeout: refresh interval for this module (default 900)
    format: display format for this module
        *(default '[{name} ][[{open_issues_count}][\?soft /]'
        '[{open_merge_requests_count}]]')*
    project: specify a project to use (default 'gitlab-org/gitlab-ce')
    thresholds: specify color thresholds to use (default [])

Format placeholders:
        See `sp` below for a full list of supported GitLab placeholders to use.
        Not all of GitLab placeholders will be usable.

    single_project:
        {name}                      project name, eg py3status
        {star_count}                number of stars, eg 2
        {forks_count}               number of forks, eg 3
        {open_issues_count}         number of open issues, eg 4
        {statistics_commit_count}   number of commits, eg 5678
    merge_requests:
        {open_merge_requests_count} number of open merge requests, eg 9
    todos:
        {todos_count}               number of todos, eg 4
    pipelines:
        {pipelines_status}          project status of pipelines, eg success

Notes:
    sp: https://docs.gitlab.com/ee/api/projects.html#get-single-project
    mr: https://docs.gitlab.com/ee/api/merge_requests.html
    td: https://docs.gitlab.com/ee/api/todos.html
    pipe: https://docs.gitlab.com/ee/api/pipelines.html

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Examples:
```
# follow a fictional project, add an icon
gitlab {
    auth_token = 'abcdefghijklmnopq-a4'
    project = 'https://gitlab.com/ultrabug/py3status'

    format = '[\?if=name [\?color=orangered&show ] {name} ]'
    format += '[[{open_issues_count}][\?soft /]'
    format += '[{open_merge_requests_count}][\?soft /]'
    format += '[{pipelines_status}]]'
}
```

@author lasers, Cyril Levis (@cyrinux)
########
# glpi #
########
Display number of open tickets from GLPI.

It features thresholds to colorize the output and forces a low timeout to
limit the impact of a server connectivity problem on your i3bar freshness.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 300)
    critical: set bad color above this threshold (default 20)
    db: database to use (default '')
    format: format of the module output (default '{tickets_open} tickets')
    host: database host to connect to (default '')
    password: login password (default '')
    timeout: timeout for database connection (default 5)
    user: login user (default '')
    warning: set degraded color above this threshold (default 15)

Format placeholders:
    {tickets_open} The number of open tickets

Color options:
    color_bad: Open ticket above critical threshold
    color_degraded: Open ticket above warning threshold

Requires:
        MySQL-python: https://pypi.org/project/MySQL-python/

@author ultrabug
###################
# google_calendar #
###################
Display upcoming Google Calendar events.

This module will display information about upcoming Google Calendar events
in one of two formats which can be toggled with a button press. The event
URL may also be opened in a web browser with a button press.

Configuration parameters:
    auth_token: The path to where the access/refresh token will be saved
        after successful credential authorization.
        (default '~/.config/py3status/google_calendar.auth_token')
    blacklist_events: Event names in this list will not be shown in the module
        (case insensitive).
        (default [])
    button_open: Opens the event URL in the default web browser.
        (default 3)
    button_refresh: Refreshes the module and updates the list of events.
        (default 2)
    button_toggle: Toggles a boolean to hide/show the data for each event.
        (default 1)
    cache_timeout: How often the module is refreshed in seconds
        (default 60)
    client_secret: the path to your client_secret file which
        contains your OAuth 2.0 credentials.
        (default '~/.config/py3status/google_calendar.client_secret')
    events_within_hours: Select events within the next given hours.
        (default 12)
    force_lowercase: Sets whether to force all event output to lower case.
        (default False)
    format: The format for module output.
        (default '{events}|\?color=event ⚇')
    format_date: The format for date related format placeholders.
        May be any Python strftime directives for dates.
        (default '%a %d-%m')
    format_event: The format for each event. The information can be toggled
        with 'button_toggle' based on the value of 'is_toggled'.
        *(default '[\?color=event {summary}][\?if=is_toggled  ({start_time}'
        ' - {end_time}, {start_date})|[ ({location})][ {format_timer}]]')*
    format_notification: The format for event warning notifications.
        (default '{summary} {start_time} - {end_time}')
    format_separator: The string used to separate individual events.
        (default ' \| ')
    format_time: The format for time-related placeholders except `{format_timer}`.
        May use any Python strftime directives for times.
        (default '%I:%M %p')
    format_timer: The format used for the {format_timer} placeholder to display
        time until an event starts or time until an event in progress is over.
        *(default '\?color=time ([\?if=days {days}d ][\?if=hours {hours}h ]'
        '[\?if=minutes {minutes}m])[\?if=is_current  left]')*
    ignore_all_day_events: Sets whether to display all day events or not.
        (default False)
    num_events: The maximum number of events to display.
        (default 3)
    response: Only display events for which the response status is
        on the list. (default ['accepted'])
    thresholds: Thresholds for events. The first entry is the color for event 1,
        the second for event 2, and so on.
        (default [])
    time_to_max: Threshold (in minutes) for when to display the `{format_timer}`
        string; e.g. if time_to_max is 60, `{format_timer}` will only be
        displayed for events starting in 60 minutes or less.
        (default 180)
    warn_threshold: The number of minutes until an event starts before a
        warning is displayed to notify the user; e.g. if warn_threshold is 30
        and an event is starting in 30 minutes or less, a notification will be
        displayed. disabled by default.
        (default 0)
    warn_timeout: The number of seconds before a warning should be issued again.
        (default 300)

Control placeholders:
    {is_toggled} a boolean toggled by button_toggle

Format placeholders:
    {events} All the events to display.

format_event and format_notification placeholders:
    {description} The description for the calendar event.
    {end_date} The end date for the event.
    {end_time} The end time for the event.
    {location} The location for the event.
    {start_date} The start date for the event.
    {start_time} The start time for the event.
    {summary} The summary (i.e. title) for the event.
    {format_timer} The time until the event starts (or until it is over
        if already in progress).

format_timer placeholders:
    {days} The number of days until the event.
    {hours} The number of hours until the event.
    {minutes} The number of minutes until the event.

Color options:
    color_event: Color for a single event.
    color_time: Color for the time associated with each event.

Requires:
        1. Python library google-api-python-client.
        2. Python library python-dateutil.
        3. OAuth 2.0 credentials for the Google Calendar api.

    Follow Step 1 of the guide here to obtain your OAuth 2.0 credentials:
    https://developers.google.com/google-apps/calendar/quickstart/python

    Download the client_secret.json file which contains your client ID and
    client secret. In your config file, set configuration parameter
    client_secret to the path to your client_secret.json file.

    The first time you run the module, a browser window will open asking you
    to authorize access to your calendar. After authorization is complete,
    an access/refresh token will be saved to the path configured in
    auth_token, and i3status will be restarted. This restart will
    occur only once after the first time you successfully authorize.

Examples:
```
# add color gradients for events and dates/times
google_calendar {
    thresholds = {
        'event': [(1, '#d0e6ff'), (2, '#bbdaff'), (3, '#99c7ff'),
            (4, '#86bcff'), (5, '#62a9ff'), (6, '#8c8cff'), (7, '#7979ff')],
        'time': [(1, '#ffcece'), (2, '#ffbfbf'), (3, '#ff9f9f'),
            (4, '#ff7f7f'), (5, '#ff5f5f'), (6, '#ff3f3f'), (7, '#ff1f1f')]
    }
}
```

@author Igor Grebenkov
@license BSD
#########
# gpmdp #
#########
Display song currently playing in Google Play Music Desktop Player.

Configuration parameters:
    cache_timeout:  refresh interval for this module (default 5)
    format:         specify the items and ordering of the data in the status bar.
        These area 1:1 match to gpmdp-remote's options
        (default '♫ {info}')

Format placeholders:
    {info}            Print info about now playing song
    {title}           Print current song title
    {artist}          Print current song artist
    {album}           Print current song album
    {album_art}       Print current song album art URL
    {time_current}    Print current song time in milliseconds
    {time_total}      Print total song time in milliseconds
    {status}          Print whether GPMDP is paused or playing
    {current}         Print now playing song in "artist - song" format


Requires:
    gpmdp: https://www.googleplaymusicdesktopplayer.com/
    gpmdp-remote: https://github.com/iandrewt/gpmdp-remote

@author Aaron Fields https://twitter.com/spirotot
@license BSD
############
# graphite #
############
Display Graphite metrics.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds.
        (default 120)
    datapoint_selection: when multiple data points are returned,
        use "max" or "min" to determine which one to display.
        (default "max")
    format: you MUST use placeholders here to display data, see below.
        (default '')
    graphite_url: URL to your graphite server. (default '')
    http_timeout: HTTP query timeout to graphite.
        (default 10)
    proxy: You can configure the proxy with HTTP or HTTPS.
        examples:
        proxy = 'https://myproxy.example.com:1234/'
        proxy = 'http://user:passwd@myproxy.example.com/'
        proxy = 'socks5://user:passwd@host:port'
        (proxy_socks is available after an 'pip install requests[socks]')
        (default None)
    targets: semicolon separated list of targets to query graphite for.
        (default '')
    threshold_bad: numerical threshold,
        if set will send a notification and colorize the output.
        (default None)
    threshold_degraded: numerical threshold,
        if set will send a notification and colorize the output.
        (default None)
    timespan: time range to query graphite for.
        (default "-2minutes")
    value_comparator: choose between "max" and "min" to compare thresholds
        to the data point value.
        (default "max")
    value_format: pretty format long numbers with "K", "M" etc.
        (default True)
    value_round: round values so they're not displayed as floats.
        (default True)

Dynamic format placeholders:
        The "format" parameter placeholders are dynamically based on the data
        points names returned by the "targets" query to graphite.

    For example if your target is `"carbon.agents.localhost-a.memUsage"`,
    you'd get a JSON result like this:

        ```
        {
            "target": "carbon.agents.localhost-a.memUsage",
            "datapoints": [[19693568.0, 1463663040]]
        }
        ```

    So the placeholder you could use on your "format" config is:
        `format = "{carbon.agents.localhost-a.memUsage}"`

    TIP: use aliases !
        ```
        targets = "alias(carbon.agents.localhost-a.memUsage, 'local_memuse')"
        format = "local carbon mem usage: {local_memuse} bytes"
        ```

Color options:
    color_bad: threshold_bad has been exceeded
    color_degraded: threshold_degraded has been exceeded

@author ultrabug
#########
# group #
#########
Group modules and switch between them.

Groups can be configured in your config. The active one of these groups is
shown in the i3bar.  The active group can be changed by a user click.  If the
click is not used by the group module then it will be passed down to the
displayed module.

Modules can be i3status core modules or py3status modules.  The active group
can be cycled through automatically.

The group can handle clicks by reacting to any that are made on it or its
content or it can use a button and only respond to clicks on that.
The way it does this is selected via the `click_mode` option.

Configuration parameters:
    align: Text alignment when fixed_width is set
        can be 'left', 'center' or 'right' (default 'center')
    button_next: Button that when clicked will switch to display next module.
        Setting to `0` will disable this action. (default 5)
    button_prev: Button that when clicked will switch to display previous
        module.  Setting to `0` will disable this action. (default 4)
    button_toggle: Button that when clicked toggles the group content being
        displayed between open and closed.
        This action is ignored if `{button}` is not in the format.
        Setting to `0` will disable this action (default 1)
    click_mode: This defines how clicks are handled by the group.
        If set to `all` then the group will respond to all click events.  This
        may cause issues with contained modules that use the same clicks that
        the group captures.  If set to `button` then only clicks that are
        directly on the `{button}` are acted on.  The group
        will need `{button}` in its format.
        (default 'all')
    cycle: Time in seconds till changing to next module to display.
        Setting to `0` will disable cycling. (default 0)
    fixed_width: Reduce the size changes when switching to new group
        (default False)
    format: display format for this module, see Examples below (default None)
    format_button_closed: Format for the button when group open
        (default  '+')
    format_button_open: Format for the button when group closed
        (default '-')
    format_closed: Format for module output when closed.
        (default "{button}")
    open: Is the group open and displaying its content. Has no effect if
        `{button}` not in format (default True)

Format placeholders:
    {button} The button to open/close or change the displayed group
    {output} Output of current active module

Examples:
```
# default formats
group {
    format = '{output}'           # if click_mode is 'all'
    format = '{output} {button}'  # if click_mode is 'button'
}

# Create a disks group that will show space on '/' and '/home'
# Change between disk modules every 30 seconds
order += "group disks"
group disks {
    cycle = 30
    format = "Disks: {output} {button}"
    click_mode = "button"

    disk "/" {
        format = "/ %avail"
    }
    disk "/home" {
        format = "/home %avail"
    }
}
```

@author tobes
###########
# hamster #
###########
Display time tracking activities from Hamster.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 10)
    format: see placeholders below (default '{current}')

Format placeholders:
    {current} current activity

Requires:
    hamster: time tracking application

@author Aaron Fields (spirotot [at] gmail.com)
@license BSD
###########
# hddtemp #
###########
Display hard drive temperatures.

hddtemp is a small utility with daemon that gives the hard drive temperature
via S.M.A.R.T. (Self-Monitoring, Analysis, and Reporting Technology). This
module requires the user-defined hddtemp daemon to be running at all times.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{format_hdd}')
    format_hdd: display format for hard drives
        (default '{name} [\?color=temperature {temperature}°{unit}]')
    format_separator: show separator if more than one (default ' ')
    thresholds: specify color thresholds to use
        *(default [(19, 'skyblue'), (24, 'deepskyblue'), (25, 'lime'),
        (41, 'yellow'), (46, 'orange'), (51, 'red'), (56, 'tomato')])*

Format placeholders:
    {format_hdd} format for hard drives

format_hdd placeholders:
    {name}        name, eg ADATA SP550
    {path}        path, eg /dev/sda
    {temperature} temperature, eg 32
    {unit}        temperature unit, eg C

Temperatures:
        Less than 25°C: Too cold     (color deepskyblue)
        25°C to 40°C: Ideal          (color good)
        41°C to 50°C: Acceptable     (color degraded)
        46°C to 50°C: Almost too hot (color orange)
        More than 50°C: Too hot      (color bad)

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    hddtemp: utility to monitor hard drive temperatures

Bible of HDD failures:
        Hard disk temperatures higher than 45°C led to higher failure rates.
        Temperatures lower than 25°C led to higher failure rates as well.
        Aging hard disk drives (3 years and older) were much more prone to
        failure when their average temperatures were 40°C and higher.

    Hard disk manufacturers often state the operating temperatures of
    their hard disk drives to be between 0°C to 60°C. This can be misleading
    because what they mean is that your hard disk will function at these
    temperatures, but it doesn't tell you anything about how long they are
    going to survive at this range.
    http://www.buildcomputers.net/hdd-temperature.html

Backblaze:
        Overall, there is not a correlation between operating temperature and
        failure rates The one exception is the Seagate Barracuda 1.5TB drives,
        which fail slightly more when they run warmer. As long as you run drives
        well within their allowed range of operating temperatures, keeping them
        cooler doesn’t matter.
        https://www.backblaze.com/blog/hard-drive-temperature-does-it-matter/

Examples:
```
# compact the format
hddtemp {
    format = 'HDD {format_hdd}'
    format_hdd = '\?color=temperature {temperature}°C'
}

# show paths instead of names
hddtemp {
    format_hdd = '{path} [\?color=temperature {temperature}°{unit}]'
}

# show more colors
hddtemp {
    gradients = True
}
```

@author lasers
############
# hueshift #
############
Shift color temperature on the screen.

Configuration parameters:
    button_down: mouse button to decrease color temperature (default 5)
    button_toggle: mouse button to toggle color temperature (default 1)
    button_up: mouse button to increase color temperature (default 4)
    command: specify blueshift, redshift, or sct to use, otherwise auto
        (default None)
    delta: specify interval value to change color temperature (default 100)
    format: display format for this module
        *(default '{name} [\?if=enabled&amp;color=darkgray disabled'
        '|[\?color=color_temperature {color_temperature}K]]')*
    maximum: specify maximum color temperature to use (default 25000)
    minimum: specify minimum color temperature to use (default 1000)
    thresholds: specify color thresholds to use
        (default [(6499, '#f6c'), (6500, '#ff6'), (6501, '#6cf')])

Control placeholders:
    {enabled} a boolean based on pgrep processing data, eg False, True

Format placeholders:
    {color_temperature} color temperature, eg 6500
    {name} name, eg Blueshift, Redshift, Sct

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    blueshift: an extensible and highly configurable alternative to redshift
    redshift: program to adjust the color temperature of your screen
    sct: set color temperature with about 40 lines of C or so

Suggestions:
    campfire: 4500
        dust storm on mars: 2000
        coffee free all nighter: 8000

Notes:
        hueshift can be disabled due to enabled running processes.
        sct and blueshift shifts only on one monitor, ideal for laptops.
        redshift shifts more than one, ideal for multi-monitors setups.

Examples:
```
# different theme
hueshift {
    format = '\?color=color_temperature ☼ {color_temperature}K'
}

# for best results, add some limitations
hueshift {
    minimum = 3000
    maximum = 10000
}
```

@author lasers
###########
# i3block #
###########
Support i3blocks blocklets in py3status.

i3blocks, https://github.com/vivien/i3blocks, is a project to allow simple
scripts to provide output to the i3bar. This module allows these blocklets to
run under py3status. The configuration of the blocklets is similar to how they
are configured in i3blocks.

Configuration parameters:
    cache_timeout: How often the blocklet should be called (in seconds).
        This is similar to cache_timeout used by standard modules. However it
        can also take the following values; `once` the blocklet will be called
        once, `repeat` the blocklet will be called constantly, or `persist`
        where the command will be expected to keep providing new data. If this
        is not set or is `None` then the blocklet will not be called unless
        clicked on. To simplify i3block compatibility, this configuration
        parameter can also be provided as `interval`.
        (default None)
    command: Path to blocklet or command (default None)
    format: What to display on the bar (default '{output}')
    instance: Will be provided to the blocklet as $BLOCK_INSTANCE (default '')
    label: Will be prepended to the blocklets output (default '')
    name: Name of the blocklet - passed as $BLOCK_NAME (default '')

Format placeholders:
    {output} The output of the blocklet

Notes:
        i3blocks and i3blocklets are subject to their respective licenses.

    This support is experimental and done for convenience to users so they
    can benefit from both worlds, issues or PRs regarding i3blocks related
    blocklets should not be raised.

    Some blocklets may return pango markup eg `<span ...` if so set
    `markup = pango` in the config for that module.

    `format` configuration parameter is used as is standard in py3status, not
    as in i3blocks configuration. Currently blocklets must provide responses
    in the standard i3blocks manner of one line per value (not as json).

Examples:
```
# i3blocks config
[time]
command=date '+%D %T'
interval=5

[wifi]
instance=wls1
label='wifi:'
command=~/i3blocks/wifi.sh
interval=5

# py3status config
order += 'i3block time'
i3block time {
    command = "date '+%D %T'"
    interval = 5
}

# different py3status config
order += 'i3block wifi'
i3block wifi {
    instance = wls1
    label = 'wifi:'
    command = '~/i3blocks/wifi.sh'
    interval = 5
}
```

@author tobes
##############
# i3pystatus #
##############
Support i3pystatus modules in py3status.

i3pystatus, https://github.com/enkore/i3pystatus, is an alternative to
py3status and provides a variety of modules. This py3status module allows
these modules to run and be display inside py3status.

Configuration parameters:
    module: specify i3pystatus module to use (default None)

Requires:
    i3pystatus: i3status replacement written in python

Examples:
```
# the modules parameters are provided as such
i3pystatus clock {
    module = 'clock'
    format = [('%a %b %-d %b %X', 'America/New_York'), ('%X', 'Etc/GMT+9')]
}

# if backend(s) are provided they should be given as a dict with the key being
# the backend name and the value being a dict of the backend settings
i3pystatus weather {
    module = 'weather'
    format = '{condition} {current_temp}{temp_unit}[ {icon}]'
    format += '[ Hi: {high_temp}][ Lo: {low_temp}][ {update_error}]'
    backend = {
        'weathercom.Weathercom': {
            'location_code': '94107:4:US',
            'units': 'imperial',
        }
    }
}

# backends that have no configuration should be defined as shown here
i3pystatus updates{
    module = 'updates'
    backends = {'dnf.Dnf': {}}
}
```

@author tobes
###########
# icinga2 #
###########
Display service status for Icinga2.

Configuration parameters:
    base_url: the base url to the icinga-web2 services list (default '')
    ca: (default True)
    cache_timeout: how often the data should be updated (default 60)
    disable_acknowledge: enable or disable counting of acknowledged
        service problems (default False)
    format: define a format string like "CRITICAL: %d"
        (default '{status_name}: {count}')
    password: password to authenticate against the icinga-web2 interface
        (default '')
    status: set the status you want to obtain
        (0=OK,1=WARNING,2=CRITICAL,3=UNKNOWN)
        (default 0)
    url_parameters: (default '?service_state={service_state}&amp;format=json')
    user: username to authenticate against the icinga-web2 interface
        (default '')

Format placeholders:
    {status_name} status name, eg OK, WARNING, CRITICAL
    {count} count, eg 0, 1, 2

@author Ben Oswald &lt;ben.oswald@root-space.de&gt;
@license BSD License &lt;https://opensource.org/licenses/BSD-2-Clause&gt;
@source https://github.com/nazco/i3status-modules
########
# imap #
########
Display number of unread messages from IMAP account.

Configuration parameters:
    allow_urgent: display urgency on unread messages (default False)
    auth_scope: scope to use with OAuth2 (default 'https://mail.google.com/')
    auth_token: path to where the pickled access/refresh token will be saved
        after successful credential authorization.
        (default '~/.config/py3status/imap_auth_token.pickle')
    cache_timeout: refresh interval for this module (default 60)
    client_secret: the path to the client secret file with OAuth 2.0
        credentials (if None then OAuth not used) (default None)
    criterion: status of emails to check for (default 'UNSEEN')
    debug: log warnings (default False)
    degraded_when_stale: color as degraded when updating failed (default True)
    format: display format for this module (default 'Mail: {unseen}')
    hide_if_zero: hide this module when no new mail (default False)
    mailbox: name of the mailbox to check (default 'INBOX')
    password: login password (default None)
    port: number to use (default '993')
    read_timeout: timeout for read(2) syscalls (default 5)
    security: login authentication method: 'ssl' or 'starttls'
        (startssl needs python 3.2 or later) (default 'ssl')
    server: server to connect (default None)
    use_idle: use IMAP4 IDLE instead of polling; requires compatible
        server; uses cache_timeout for IDLE's timeout; will auto detect
        when set to None (default None)
    user: login user (default None)

Format placeholders:
    {unseen} number of unread emails

Color options:
    color_new_mail: use color when new mail arrives, default to color_good

OAuth:
        OAuth2 will be used for authentication instead of a password if the
        client_secret path is set.

    To create a client_secret for your Google account, visit
    https://console.developers.google.com/ and create an "OAuth client ID" from
    the credentials tab.

    This client secret enables the app (in this case, the IMAP py3status module)
    to request access to a user's email. Therefore the client secret doesn't
    have to be for the same Google account as the email account being accessed.

    When the IMAP module first tries to access your email account a browser
    window will open asking for authorization to access your email.
    After authorization is complete, an access/refresh token will be saved to
    the path configured in auth_token.

    Requires: Using OAuth requires the google-auth and google-auth-oauthlib
    libraries to be installed.

    Note: the same client secret file can be used as with the py3status Google
    Calendar module.

@author obb, girst
##########
# insync #
##########
Display Insync status.

Thanks to Iain Tatch &lt;iain.tatch@gmail.com&gt; for the script that this is based on.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{status} {queued}')
    status_offline: show when Insync is offline (default 'OFFLINE')
    status_paused: show when Insync is paused (default 'PAUSED')
    status_share: show when Insync is sharing (default 'SHARE')
    status_synced: show when Insync has finished syncing (default 'SYNCED')
    status_syncing: show when Insync is syncing (default 'SYNCING')

Format placeholders:
    {status} Insync status
    {queued} Number of files queued

Color options:
    color_bad: Offline
    color_degraded: Default (e.g. Paused/Syncing)
    color_good: Synced

Requires:
    insync: an unofficial Google Drive client with support for various desktops

@author Joshua Pratt &lt;jp10010101010000@gmail.com&gt;
@license BSD
################
# kdeconnector #
################
Display information about your smartphone with KDEConnector.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 30)
    device: the device name, you need this if you have more than one device
        connected to your PC (default None)
    device_id: alternatively to the device name you can set your device id here
        (default None)
    format: see placeholders below
        (default '{name}{notif_status} {bat_status} {charge}%')
    format_disconnected: text if device is disconnected
        (default 'device disconnected')
    low_threshold: percentage value when text is twitch to color_bad
        (default 20)
    status_bat: text when battery is discharged (default '⬇')
    status_chr: text when device is charged (default '⬆')
    status_full: text when battery is full (default '☻')
    status_no_notif: text when you have no notifications (default '')
    status_notif: text when notifications are available (default ' ✉')

Format placeholders:
    {bat_status} battery state
    {charge} the battery charge
    {name} name of the device
    {notif_size} number of notifications
    {notif_status} shows if a notification is available or not

Color options:
    color_bad: Device unknown, unavailable
        or battery below low_threshold and not charging
    color_degraded: Connected and battery not charging
    color_good: Connected and battery charging

Requires:
    pydbus: pythonic d-bus library
    kdeconnect: adds communication between kde and your smartphone

Examples:
```
kdeconnector {
    device_id = "aa0844d33ac6ca03"
    format = "{name} {battery} ⚡ {state}"
    low_battery = "10"
}
```

@author Moritz Lüdecke
###################
# keyboard_layout #
###################
Display keyboard layout.

Configuration parameters:
    button_next: mouse button to cycle next layout (default 4)
    button_prev: mouse button to cycle previous layout (default 5)
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{layout}')
    layouts: specify a list of layouts to use (default None)

Format placeholders:
    {layout} keyboard layout

Color options:
    color_<layout>: colorize the layout. eg color_fr = '#729FCF'

Requires:
    xkblayout-state:
        or
    setxkbmap: and `xset` (works for the first two predefined layouts. overrides `XkbLayout` when switching layout.)

Examples:
```
# define keyboard layouts that can be switched between
keyboard_layout {
    layouts = ['gb', 'fr', 'dvorak']
}
```

@author shadowprince, tuxitop
@license Eclipse Public License
##################
# keyboard_locks #
##################
Display NumLock, CapsLock, and ScrLock keys.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 1)
    format: display format for this module
        *(default '[\?if=num_lock&amp;color=good NUM|\?color=bad NUM] '
        '[\?if=caps_lock&amp;color=good CAPS|\?color=bad CAPS] '
        '[\?if=scroll_lock&amp;color=good SCR|\?color=bad SCR]')*

Control placeholders:
    {num_lock} a boolean based on xset data
    {caps_lock} a boolean based on xset data
    {scroll_lock} a boolean based on xset data

Color options:
    color_good: Lock on
    color_bad: Lock off

Examples:
```
# hide NUM, CAPS, SCR
keyboard_locks {
    format = '\?color=good [\?if=num_lock NUM][\?soft  ]'
    format += '[\?if=caps_lock CAPS][\?soft  ][\?if=scroll_lock SCR]'
}
```

@author lasers
#################
# khal_calendar #
#################
Displays upcoming khal events.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 60)
    config_path: Path to khal configuration file. The default None resolves to /home/$USER/.config/khal/config (default None)
    date_end: Until which datetime the module searches for events (default 'eod')
    format: display format for this module (default '{appointments}')
    output_format: khal conform format for displaying event output (default '{start-time} {title}')

Format placeholders:
    {appointments} list of events in time range

Requires:
    khal: https://github.com/pimutils/khal

@author @xenrox
@license BSD
##############
# lm_sensors #
##############
Display temperatures, voltages, fans, and more from hardware sensors.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    chips: specify a list of chips to use (default [])
    format: display format for this module (default '{format_chip}')
    format_chip: display format for chips (default '{name} {format_sensor}')
    format_chip_separator: show separator if more than one (default ' ')
    format_sensor: display format for sensors
        (default '[\?color=darkgray {name}] [\?color=auto.input&amp;show {input}]')
    format_sensor_separator: show separator if more than one (default ' ')
    sensors: specify a list of sensors to use (default [])
    thresholds: specify color thresholds to use (default {'auto.input': True})

Format placeholders:
    {format_chip}   format for chips

Format_chip placeholders:
    {name}          chip name, eg coretemp-isa-0000, nouveau-pci-0500
    {adapter}       adapter type, eg ISA adapter, PCI adapter
    {format_sensor} format for sensors

Format_sensor placeholders:
    {name}          sensor name, eg core_0, gpu_core, temp1, fan1

    See `sensors -u` for a full list of placeholders for `format_chip`,
    `format_sensors` without the prefixes, `chips` and `sensors` options.

    See https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface
    for more information on the sensor placeholders.

Color options for `auto.input` threshold:
    color_zero: zero value or less (color red)
    color_min: minimum value (color lightgreen)
    color_excl_input: input value excluded from threshold (color None)
    color_input: input value (color lime)
    color_near_max: input value near maximum value (color yellow)
    color_max: maximum value (color orange)
    color_near_crit: input value near critical value (color lightcoral)
    color_crit: critical value (color red)

Color thresholds:
    format_sensor:
        xxx: print a color based on the value of `xxx` placeholder
        auto.input: print a color based on the value of `input` placeholder
        against a customized threshold

Requires:
    lm_sensors: a tool to read temperature/voltage/fan sensors
    sensors-detect: see `man sensors-detect # --auto` to read about
        using defaults or to compile a list of kernel modules

Examples:
```
# identify possible chips, sensors, placeholders, etc
    [user@py3status ~] $ sensors -u
    ----------------------------- # ──────────────────────────────────────
    coretemp-isa-0000             # chip {name}         # chip: coretemp*
    Adapter: ISA adapter          #  ├── {adapter} type
    ----                          #  │------------------------------------
    Core 0:                       #  ├── sensor {name}  # sensor: core_0
      temp2_input: 48.000         #  │    ├── {input}
      temp2_max: 81.000           #  │    ├── {max}
      temp2_crit: 91.000          #  │    ├── {crit}
      temp2_crit_alarm: 0.000     #  │    └── {crit_alarm}
    Core 1:                       #  └── sensor {name}  # sensor: core_1
      temp3_input: 48.000         #       ├── {input}
      temp3_max: 81.000           #       ├── {max}
      temp3_crit: 91.000          #       ├── {crit}
      temp3_crit_alarm: 0.000     #       └── {crit_alarm}
                                  # ──────────────────────────────────────
    k10temp-pci-00c3              # chip {name}         # chip: k10temp*
    Adapter: PCI adapter          #  ├── {adapter} type
    ----                          #  │------------------------------------
    temp1:                        #  ├── sensor {name}  # sensor: temp1
      temp1_input: 30.000         #  │    ├── {input}
      temp1_max: -71.000          #  │    ├── {max}
      temp1_min: -15.000          #  │    ├── {min}
      temp1_alarm: 1.000          #  │    ├── {alarm}
      temp1_offset: 0.000         #  │    ├── {offset}
      temp1_beep: 0.000           #  │    └── {beep}
    intrusion0:                   #  └── sensor {name}  # sensor: intrusion0
      intrusion0_alarm: 0.000     #       └── {alarm}

    Solid lines denotes chips. Dashed lines denotes sensors.
    Sensor names are lowercased and its spaces replaced with underscores.
    The numbered prefixes, eg `temp1_*` are removed to keep names clean.

# specify chips to use
lm_sensors {
    chips = ['coretemp-isa-0000']  # full
        OR
    chips = ['coretemp*']  # fnmatch
}

# specify sensors to use
lm_sensors {
    sensors = ['core_0', 'core_1', 'core_2', 'core_3']  # full
        OR
    sensors = ['core_*']  # fnmatch
}

# show name per chip, eg CPU 35°C 36°C 37°C 39°C GPU 52°C
lm_sensors {
    format_chip = '[\?if=name=coretemp-isa-0000 CPU ]'
    format_chip += '[\?if=name=nouveau-pci-0500 GPU ]'
    format_chip += '{format_sensor}'
    format_sensor = '\?color=auto.input {input}°C'
    sensors = ['core*', 'temp*']
}

# show name per sensor, eg CPU1 35°C CPU2 36°C CPU3 37°C CPU4 39°C GPU 52°C
lm_sensors {
    format_chip = '{format_sensor}'
    format_sensor = '[\?if=name=core_0 CPU1 ]'
    format_sensor += '[\?if=name=core_1 CPU2 ]'
    format_sensor += '[\?if=name=core_2 CPU3 ]'
    format_sensor += '[\?if=name=core_3 CPU4 ]'
    format_sensor += '[\?if=name=gpu_core GPU ]'
    format_sensor += '[\?color=auto.input {input}°C]'
    sensors = ['core*', 'temp*']
}
```

@author lasers
###########
# loadavg #
###########
Display average system load over a period of time.

In UNIX computing, the system load is a measure of the amount of computational
work that a computer system performs. The load average represents the average
system load over a period of time. It conventionally appears in the form of
three numbers which represent the system load during the last one-, five-,
and fifteen-minute periods.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module
        *(default 'Loadavg [\?color=1avg {1min}] '
        '[\?color=5avg {5min}] [\?color=15avg {15min}]')*
    thresholds: specify color thresholds to use
        *(default [(0, '#9dd7fb'), (20, 'good'),
        (40, 'degraded'), (60, '#ffa500'), (80, 'bad')])*

Format placeholders:
    {1min} load average during the last 1-minute, eg 1.44
    {5min} load average during the last 5-minutes, eg 1.66
    {15min} load average during the last 15-minutes, eg 1.52
    {1avg} load average percentage during the last 1-minute, eg 12.00
    {5avg} load average percentage during the last 5-minutes, eg 13.83
    {15avg} load average percentage during the last 15-minutes, eg 12.67

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Notes:
        http://blog.scoutapp.com/articles/2009/07/31/understanding-load-averages
        http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html

Examples:
```
# show load averages with static colors
loadavg {
    format = 'Loadavg [\?color=orange {1min} ][\?color=gold {5min} {15min}]'
}

# remove prefix - easy copy and paste
loadavg {
    format = '[\?color=1avg {1min}] '
    format += '[\?color=5avg {5min}] '
    format += '[\?color=15avg {15min}]'
}

# show detailed load averages + percentages
loadavg {
    format = 'Loadavg [\?color=darkgray '
    format += '1min [\?color=1avg {1min}]\|[\?color=1avg {1avg}%] '
    format += '5min [\?color=5avg {5min}]\|[\?color=5avg {5avg}%] '
    format += '15min [\?color=15avg {15min}]\|[\?color=15avg {15avg}%]]'
}

# show load averages with different colors + thresholds
loadavg {
    # htop - default
        (0, '#9dd7fb'),     # 1avg
        (0, 'cyan'),        # 5avg
        (0, 'darkcyan'),    $ 15avg

    # htop - monochrome
        (0, '#9dd7fb'),     # 1avg
        (0, None),          # 5avg
        (0, None),          # 15avg

    # htop - black night
        (0, 'greenyellow'), # 1avg
        (0, 'limegreen'),   # 5avg
        (0, 'limegreen'),   # 15avg

    # htop - mc
        (0, '#ffffff'),     # 1avg
        (0, '#aaaaaa'),     # 5avg
        (0, '#555555'),     # 15avg

    # three shades of blue
        (0, '#87cefa'),     # 1avg
        (0, '#4bb6f8'),     # 5avg
        (0, '#0991e5'),     # 15avg

    # three shades of gray
        (0, '#dddddd'),     # 1avg
        (0, '#bbbbbb'),     # 5avg
        (0, '#999999'),     # 15avg

    # htop - mc and three shades of gray is similar. htop - mc
    # have higher contrast between time periods over three shades
    # of gray for better readability. your mileage may vary.

    thresholds = {
        '1avg': [
            (0, 'REPLACE_ME'),
            (20, 'good'), (40, 'degraded'),
            (60, '#ffa500'), (80, 'bad')
        ],
        '5avg': [
            (0, 'REPLACE_ME'),
            (20, 'good'), (40, 'degraded'),
            (60, '#ffa500'), (80, 'bad')
        ],
        '15avg': [
            (0, 'REPLACE_ME'),
            (20, 'good'), (40, 'degraded'),
            (60, '#ffa500'), (80, 'bad')
        ],
    }
}

# don't show load averages if 1avg is under 60%
loadavg {
    format = '[\?if=1avg>59 Loadavg [\?color=1avg {1min}] '
    format += '[\?color=5avg {5min}] [\?color=15avg {15min}]]'
}

# add your snippets here
loadavg {
    format = "..."
}
```

@author lasers
########
# mail #
########
Display number of messages in various mailbox formats.
This module supports Maildir, mbox, MH, Babyl, MMDF, and IMAP.

Configuration parameters:
    accounts: specify a dict consisting of mailbox types and a list of dicts
        consisting of mailbox settings and/or paths to use (default {})
    cache_timeout: refresh interval for this module (default 60)
    format: display format for this module
        (default '\?not_zero Mail {mail}|No Mail')
    thresholds: specify color thresholds to use (default [])

Format placeholders:
    {mail}    number of messages
    {maildir} number of Maildir messages
    {mbox}    number of mbox messages
    {mh}      number of MH messages
    {babyl}   number of Babyl messages
    {mmdf}    number of MMDF messages
    {imap}    number of IMAP messages

    We can divide mailbox, eg `{maildir}`, into numbered placeholders based
    on number of mailbox accounts, eg `{maildir_1}`, and if we add `name` to
    a mailbox account, we can use `{name}` placeholder instead, eg `{home}`.

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

IMAP Subscriptions:
        You can specify a list of filters to decide which folders to search.
        By default, we search only the INBOX folder (ie: `['^INBOX$']`). We
        can use regular expressions, so if you use more than one, it would
        be joined by a logical operator `or`.

    `'.*'` will match all folders.
    `'pattern'` will match folders containing `pattern`.
    `'^pattern'` will match folders beginning with `pattern`.
    `'pattern$'` will match folders ending with `pattern`.
    `'^((?![Ss][Pp][Aa][Mm]).)*$'` will match all folders
    except for every possible case of `spam` folders.

    For more documentation, see https://docs.python.org/3/library/re.html
    and/or any regex builder on the web. Don't forget to escape characters.

Examples:
```
# add multiple accounts
mail {                                       #
    accounts = {                             #     {mail}
        'maildir': [                         #      ├── {maildir}
            {'path': '~/.mutt'},             #      │    ├── {maildir_1}
            {'path': '~/Mail'},              #      │    └── {maildir_2}
        ],                                   #      │
        'mbox': [                            #      ├── {mbox}
            {'path': '~/home.mbox'},         #      │    ├── {mbox_1}
            {                                #      │    ├── {mbox_2}
                'name': 'local',             # <----│----│----└── {local}
                'path': '~/mbox'             #      │    │
            },                               #      │    │
            {                                #      │    └── {mbox_3}
                'name': 'debian',            # <----│---------└── {debian}
                'path': '/var/mail/$USER'    #      │
                'urgent': False,             # <----│---- disable urgent
            },                               #      │
        ],                                   #      │
        'mh': [                              #      ├── {mh}
            {'path': '~/mh_mail'},           #      │    └── {mh_1}
        ],                                   #      │
        'babyl': [                           #      ├── {babyl}
            {'path': '~/babyl_mail'},        #      │    └── {babyl_1}
        ],                                   #      │
        'mmdf': [                            #      ├── {mmdf}
            {'path': '~/mmdf_mail'},         #      │    └── {mmdf_1}
        ]                                    #      │
        'imap': [                            #      ├── {imap}
            {                                #      │    ├── {imap_1}
                'name': 'home',              # <----│----│----└── {home}
                'user': 'lasers',            #      │    │
                'password': 'kiss_my_butt!', #      │    │
                'server': 'imap.gmail.com',  #      │    │
                                             #  <---│----│ no filters to
                'port': 993,                 #      │    │ search folders, use
                                             #      │    │ filters ['^INBOX$']
            },                               #      │    │
            {                                #      │    └── {imap_2}
                'name': 'work',              # <----│---------└── {work}
                'user': 'tobes',             #      │
                'password': 'i_love_python', #
                'server': 'imap.yahoo.com',  #
                                             # <---- no port, use port 993
                'urgent': False,             # <---- disable urgent
                                             #       for this account
                'filters': ['^INBOX$']       # <---- specify a list of filters
                                             #       to search folders
                'log': True,                 # <---- print a list of folders
            }                                #       to filter in the log
        ]
    }
    allow_urgent = False             <---- disable urgent for all accounts
}

# add colors, disable urgent
mail {
    format = '[\?color=mail&show Mail] {mail}'
    thresholds = [(1, 'good'), (5, 'degraded'), (15, 'bad')]
    allow_urgent = False
}

# identify the mailboxes, remove what you don't need
mail {
    format = '[\?color=mail '
    format += '[\?if=imap&color=#00ff00 IMAP ]'
    format += '[\?if=maildir&color=#ffff00 MAILDIR ]'
    format += '[\?if=mbox&color=#ff0000 MBOX ]'
    format += '[\?if=babyl&color=#ffa500 BABYL ]'
    format += '[\?if=mmdf&color=#00bfff MMDF ]'
    format += '[\?if=mh&color=#ee82ee MH ]'
    format += ']'
    format += '[\?not_zero&color Mail {mail}|No Mail]'
}

# individual colorized mailboxes, remove what you don't need
mail {
    format = '[\?if=imap&color=#00ff00 IMAP] {imap} '
    format += '[\?if=maildir&color=#ffff00 MAILDIR] {maildir} '
    format += '[\?if=mbox&color=#ff0000 MBOX] {mbox} '
    format += '[\?if=babyl&color=#ffa500 BABYL] {babyl} '
    format += '[\?if=mmdf&color=#00bfff MMDF] {mmdf} '
    format += '[\?if=mh&color=#ee82ee MH] {mh}'
    allow_urgent = False
}
```

@author lasers
#############
# mega_sync #
#############
Display status of MEGAcmd.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for the module (default "MEGA {format_sync}|No MEGA")
    format_sync: display format for every sync (default "{syncstate}")
    format_sync_separator: show separator if more than one sync (default " ")

Format placeholders:
    {format_sync} Format for every sync returned by 'mega-sync' command.

format_sync placeholders:
        Any column returned by 'mega-sync' command - in lower case!
        For example: id, syncstate, localpath

Requires:
        MEGAcmd: command-line interface for MEGA

@author Maxim Baz (https://github.com/maximbaz)
@license BSD
#######
# moc #
#######
Display song currently playing in moc.

MOC (music on console) is a console audio player for Linux/Unix designed to be
powerful and easy to use. It consists of two parts, a server (moc) and a
player/interface (mocp). It supports OGG, WAV, MP3 and other formats.

Configuration parameters:
    button_next: mouse button to skip next track (default None)
    button_pause: mouse button to pause/play the playback (default 1)
    button_previous: mouse button to skip previous track (default None)
    button_stop: mouse button to stop the playback (default 3)
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module
        *(default '\?if=is_started [\?if=is_stopped \[\] moc|'
        '[\?if=is_paused \|\|][\?if=is_playing &gt;] {title}]')*
    sleep_timeout: when moc is not running, this interval will be used to
        allow one to refresh constantly with time placeholders and/or
        to refresh once every minute rather than every few seconds
        (default 20)

Control placeholders:
    {is_paused} a boolean based on moc status
    {is_playing} a boolean based on moc status
    {is_started} a boolean based on moc status
    {is_stopped} a boolean based on moc status

Format placeholders:
    {album} album name, eg (new output here)
    {artist} artist name, eg (new output here)
    {avgbitrate} audio average bitrate, eg 230kbps
    {bitrate} audio bitrate, eg 230kbps
    {currentsec} elapsed time in seconds, eg 32
    {currenttime} elapsed time in [HH:]MM:SS, eg 00:32
    {file} file location, eg /home/user/Music...
    {rate} audio rate, eg 44kHz
    {songtitle} song title, eg (new output here)
    {state} playback state, eg PLAY, PAUSE, STOP
    {timeleft} time left in [HH:]MM:SS, eg 71:30
    {title} track title, eg (new output here)
    {totalsec} total time in seconds, eg 4322
    {totaltime} total time in seconds, eg 72:02

    Placeholders are retrieved directly from `mocp --info` command.
    The list was harvested once and should not represent a full list.

Color options:
    color_paused: Paused, defaults to color_degraded
    color_playing: Playing, defaults to color_good
    color_stopped: Stopped, defaults to color_bad

Requires:
    moc: a console audio player with simple ncurses interface

Examples:
```
# see 'man mocp' for more buttons
moc {
    on_click 9 = 'exec mocp --example'
}
```

@author lasers
##############
# mpd_status #
##############
Display song currently playing in mpd.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 2)
    format: template string (see below)
        (default '{state} [[[{artist}] - {title}]|[{file}]]')
    hide_on_error: hide the status if an error has occurred (default False)
    hide_when_paused: hide the status if state is paused (default False)
    hide_when_stopped: hide the status if state is stopped (default True)
    host: mpd host (default 'localhost')
    idle_subsystems: a list of subsystems to idle on.
        player: changes in song information, play state
        mixer: changes in volume
        options: e.g. repeat mode
        See the MPD protocol documentation for additional events.
        (default ['player', 'playlist', 'mixer', 'options'])
    idle_timeout: force idle to reset every n seconds (default 3600)
    max_width: maximum status length (default 120)
    password: mpd password (default None)
    port: mpd port (default '6600')
    state_pause: label to display for "paused" state (default '[pause]')
    state_play: label to display for "playing" state (default '[play]')
    state_stop: label to display for "stopped" state (default '[stop]')
    use_idle: whether to use idling instead of polling. None to autodetect
        (default None)

Format placeholders:
    {state} state (paused, playing. stopped) can be defined via `state_..`
        configuration parameters
        Refer to the mpc(1) manual page for the list of available placeholders to
        be used in the format.  Placeholders should use braces `{}` rather than
        percent `%%` eg `{artist}`.
        Every placeholder can also be prefixed with
        `next_` to retrieve the data for the song following the one currently
        playing.

Color options:
    color_pause: Paused, default color_degraded
    color_play: Playing, default color_good
    color_stop: Stopped, default color_bad

Requires:
    python-mpd2: (NOT python2-mpd2)

Examples:
```
# Show state and (artist -) title, if no title fallback to file:
{state} [[[{artist} - ]{title}]|[{file}]]

# Show state, [duration], title (or file) and next song title (or file):
{state} \[{time}\] [{title}|{file}] → [{next_title}|{next_file}]
```

@author shadowprince, zopieux
@license Eclipse Public License
#########
# mpris #
#########
Display song/video and control MPRIS compatible players.

There are two ways to control the media player. Either by clicking with a mouse
button in the text information or by using buttons. For former you have
to define the button parameters in your config.

Configuration parameters:
    button_next: mouse button to play the next entry (default None)
    button_previous: mouse button to play the previous entry (default None)
    button_stop: mouse button to stop the player (default None)
    button_toggle: mouse button to toggle between play and pause mode (default 1)
    format: see placeholders below
    format: display format for this module
        (default '[{artist} - ][{title}] {previous} {toggle} {next}')
    format_none: define output if no player is running
        (default 'no player running')
    icon_next: specify icon for next button (default u'▹')
    icon_pause: specify icon for pause button (default u'◫')
    icon_play: specify icon for play button (default u'▷')
    icon_previous: specify icon for previous button (default u'◃')
    icon_stop: specify icon for stop button (default u'□')
    player_priority: priority of the players.
        Keep in mind that the state has a higher priority than
        player_priority. So when player_priority is "[mpd, bomi]" and mpd is
        paused and bomi is playing than bomi wins. (default [])
    state_pause: specify icon for pause state (default u'◫')
    state_play: specify icon for play state (default u'▷')
    state_stop: specify icon for stop state (default u'□')

Format placeholders:
    {album} album name
    {artist} artiste name (first one)
    {length} time duration of the song
    {player} show name of the player
    {state} playback status of the player
    {time} played time of the song
    {title} name of the song
    {nowplaying} now playing field provided by VLC for stream info

Button placeholders:
    {next} play the next title
    {pause} pause the player
    {play} play the player
    {previous} play the previous title
    {stop} stop the player
    {toggle} toggle between play and pause

Color options:
    color_control_inactive: button is not clickable
    color_control_active: button is clickable
    color_paused: song is paused, defaults to color_degraded
    color_playing: song is playing, defaults to color_good
    color_stopped: song is stopped, defaults to color_bad

Requires:
    pydbus: pythonic d-bus library

Tested players:
    bomi: powerful and easy-to-use gui multimedia player based on mpv
    cantata: qt5 client for the music player daemon (mpd)
    mpdris2: mpris2 support for mpd
    vlc: multi-platform mpeg, vcd/dvd, and divx player

Examples:
```
mpris {
    format = "{previous}{play}{next} {player}: {state} [[{artist} - {title}]|[{title}]]"
    format_none = "no player"
    player_priority = "[mpd, cantata, vlc, bomi, *]"
}

only show information from mpd and vlc, but mpd has a higher priority:
mpris {
    player_priority = "[mpd, vlc]"
}

show information of all players, but mpd and vlc have the highest priority:
mpris {
    player_priority = "[mpd, vlc, *]"
}

vlc has the lowest priority:
mpris {
    player_priority = "[*, vlc]"
}
```

@author Moritz Lüdecke, tobes, valdur55
##############
# net_iplist #
##############
Display list of network interfaces and IP addresses.

This module supports both IPv4 and IPv6. There is the possibility to blacklist
interfaces and IPs, as well as to show interfaces with no IP address. It will
show an alternate text if no IP are available.

Configuration parameters:
    cache_timeout: refresh interval for this module in seconds.
        (default 30)
    format: format of the output.
        (default 'Network: {format_iface}')
    format_iface: format string for the list of IPs of each interface.
        (default '{iface}:[ {ip4}][ {ip6}]')
    format_no_ip: string to show if there are no IPs to display.
        (default 'no connection')
    iface_blacklist: list of interfaces to ignore. Accepts shell-style wildcards.
        (default ['lo'])
    iface_sep: string to write between interfaces.
        (default ' ')
    ip_blacklist: list of IPs to ignore. Accepts shell-style wildcards.
        (default [])
    ip_sep: string to write between IP addresses.
        (default ',')
    remove_empty: do not show interfaces with no IP.
        (default True)

Format placeholders:
    {format_iface} the format_iface string.

Format placeholders for format_iface:
    {iface} name of the interface.
    {ip4} list of IPv4 of the interface.
    {ip6} list of IPv6 of the interface.

Color options:
    color_bad: no IPs to show
    color_good: IPs to show

Requires:
    ip: utility found in iproute2 package

Examples:
```
net_iplist {
    iface_blacklist = []
    ip_blacklist = ['127.*', '::1']
}
```

@author guiniol
############
# net_rate #
############
Display network transfer rate.

Configuration parameters:
    all_interfaces: ignore self.interfaces, but not self.interfaces_blacklist
        (default True)
    cache_timeout: how often we refresh this module in seconds
        (default 2)
    devfile: location of dev file under /proc
        (default '/proc/net/dev')
    format: format of the module output
        (default '{interface}: {total}')
    format_no_connection: when there is no data transmitted from the start of the plugin
        (default '')
    format_value: format to use for values
        (default "[\?min_length=11 {value:.1f} {unit}]")
    hide_if_zero: hide indicator if rate == 0
        (default False)
    interfaces: comma separated list of interfaces to track
        (default [])
    interfaces_blacklist: comma separated list of interfaces to ignore
        (default 'lo')
    si_units: use SI units
        (default False)
    sum_values: sum values of each interface instead of taking the top one
        (default False)
    thresholds: specify color thresholds to use
        (default [(0, 'bad'), (1024, 'degraded'), (1024 * 1024, 'good')])
    unit: unit to use. If the unit contains a multiplier prefix, only this
        exact unit will ever be used
        (default "B/s")

Format placeholders:
    {down} download rate
    {interface} name of interface
    {total} total rate
    {up} upload rate

format_value placeholders:
    {unit} current unit
    {value} numeric value

Color thresholds:
    {down} Change color based on the value of down
    {total} Change color based on the value of total
    {up} Change color based on the value of up

@author shadowprince
@license Eclipse Public License
###########
# netdata #
###########
Display network speed and bandwidth usage.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 2)
    format: display format for this module
        *(default '{nic} [\?color=down LAN(Kb): {down}↓ {up}↑] '
        '[\?color=total T(Mb): {download}↓ {upload}↑ {total}↕]')*
    nic: specify a network interface to use (default None)
    thresholds: specify color thresholds to use
        *(default {'down': [(0, 'bad'), (30, 'degraded'), (60, 'good')],
        'total': [(0, 'good'), (400, 'degraded'), (700, 'bad')]})*

Format placeholders:
    {nic}      network interface
    {down}     number of download speed
    {up}       number of upload speed
    {download} number of download usage
    {upload}   number of upload usage
    {total}    number of total usage

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

@author Shahin Azad <ishahinism at Gmail>
##################
# networkmanager #
##################
Display NetworkManager fields via nmcli, a command-line tool.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    devices: specify a list of devices to use (default ['[e|w]*'])
    format: display format for this module (default '{format_device}')
    format_device: format for devices
        *(default "[\?if=general_connection {general_device}[\?soft  ]"
        "[\?color=ap_signal {ap_ssid} {ap_bars} {ap_signal}%][\?soft  ]"
        "[\?color=good {ip4_address1}]]")*
    format_device_separator: show separator if more than one (default ' ')
    thresholds: specify color thresholds to use
        (default [(0, 'bad'), (30, 'degraded'), (65, 'good')])

Format placeholders:
    {format_device} format for devices

Format_device placeholders:
    {general_connection} eg Py3status, Wired Connection 1
    {general_device}     eg wlp3s0b1, enp2s0
    {general_type}       eg wifi, ethernet
    {ap_bars}            signal strength in bars, eg ▂▄▆_
    {ap_chan}            wifi channel, eg 6
    {ap_mode}            network mode, eg Adhoc or Infra
    {ap_rate}            bitrate, eg 54 Mbit/s
    {ap_security}        signal security, eg WPA2
    {ap_signal}          signal strength in percentage, eg 63
    {ap_ssid}            ssid name, eg Py3status
    {ip4_address1}       eg 192.168.1.108
    {ip6_address1}       eg 0000::0000:0000:0000:0000

    Use `nmcli --terse --fields=general,ap,ip4,ip6 device show` for a full list of
    supported NetworkManager fields to use. Not all of NetworkManager fields will
    be usable. See `man nmcli` for more information.

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    nmcli: cli configuration utility for NetworkManager

Examples:
```
# specify devices to use
networkmanager {
    devices = ['e*']    # ethernet only
    devices = ['w*']    # wireless only
    devices = []        # ethernet, wireless, lo, etc
}
```

@author Kevin Pulo &lt;kev@pulo.com.au&gt;
@license BSD
##############
# ns_checker #
##############
Display DNS resolution success on a configured domain.

This module launch a simple query on each nameservers for the specified domain.
Nameservers are dynamically retrieved. The FQDN is the only one mandatory
parameter.  It's also possible to add additional nameservers by appending them
in nameservers list.

The default resolver can be overwritten with my_resolver.nameservers parameter.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 300)
    domain: domain name to check (default '')
    format: output format string (default '{total_count} NS {status}')
    lifetime: resolver lifetime (default 0.3)
    nameservers: specify a list of reference DNS nameservers (default [])
    resolvers: specify a list of DNS resolvers to use (default [])

Format placeholders:
    {nok_count} The number of failed name servers
    {ok_count} The number of working name servers
    {status} The overall status of the name servers (OK or NOK)
    {total_count} The total number of name servers

Color options:
    color_bad: One or more lookups have failed
    color_good: All lookups have succeeded

Requires:
    dnspython: a dns toolkit for python

@author nawadanp
##############
# nvidia_smi #
##############
Display NVIDIA properties currently exhibiting in the NVIDIA GPUs.

nvidia-smi, short for NVIDIA System Management Interface program, is a cross
platform tool that supports all standard NVIDIA driver-supported Linux distros.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{format_gpu}')
    format_gpu: display format for NVIDIA GPUs
        *(default '{gpu_name} [\?color=temperature.gpu {temperature.gpu}°C] '
        '[\?color=memory.used_percent {memory.used_percent}%]')*
    format_gpu_separator: show separator if more than one (default ' ')
    memory_unit: specify memory unit, eg 'KiB', 'MiB', 'GiB', otherwise auto
        (default None)
    thresholds: specify color thresholds to use
        (default [(0, 'good'), (65, 'degraded'), (75, 'orange'), (85, 'bad')])

Format placeholders:
    {format_gpu} format for NVIDIA GPUs

format_gpu placeholders:
    {index}               Zero based index of the GPU.
    {count}               The number of NVIDIA GPUs in the system
    {driver_version}      The version of the installed NVIDIA display driver
    {gpu_name}            The official product name of the GPU
    {gpu_uuid}            Globally unique immutable identifier of the GPU
    {memory.free}         Total free memory
    {memory.free_unit}    Total free memory unit
    {memory.total}        Total installed GPU memory
    {memory.total_unit}   Total installed GPU memory unit
    {memory.used}         Total memory allocated by active contexts
    {memory.used_percent} Total memory allocated by active contexts percentage
    {memory.used_unit}    Total memory unit
    {temperature.gpu}     Core GPU temperature in degrees C

    Use `python /path/to/nvidia_smi.py --list-properties` for a full list of
    supported NVIDIA properties to use. Not all of supported NVIDIA properties
    will be usable. See `nvidia-smi --help-query-gpu` for more information.

Color thresholds:
    format_gpu:
        `xxx`: print a color based on the value of NVIDIA `xxx` property

Requires:
    nvidia-smi: command line interface to query NVIDIA devices

Examples:
```
# display nvidia properties
nvidia_smi {
    format_gpu = '{gpu_name} [\?color=temperature.gpu {temperature.gpu}°C] '
    format_gpu += '[\?color=memory.used_percent {memory.used} {memory.used_unit}'
    format_gpu += '[\?color=darkgray&show \|]{memory.used_percent:.1f}%]'
}
```

@author lasers
#################
# online_status #
#################
Determine if you have an Internet Connection.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{icon}')
    icon_off: show when connection is offline (default '■')
    icon_on: show when connection is online (default '●')
    timeout: time to wait for a response, in seconds (default 2)
    url: specify URL to connect when checking for a connection
        (default 'https://www.google.com')

Format placeholders:
    {icon} connection status

Color options:
    color_off: Connection offline, defaults to color_bad
    color_on: Connection online, defaults to color_good

@author obb
###########
# pingdom #
###########
Display response times of the configured Pingdom checks.

We also verify the status of the checks and colorize if needed.
Pingdom API doc : https://www.pingdom.com/features/api/documentation/

Configuration parameters:
    app_key: create an APP KEY on pingdom first (default '')
    cache_timeout: how often to refresh the check from pingdom (default 600)
    checks: comma separated pindgom check names to display (default '')
    format: display format for this module (default '{pingdom}')
    login: pingdom login (default '')
    max_latency: maximal latency before coloring the output (default 500)
    password: pingdom password (default '')
    request_timeout: pindgom API request timeout (default 10)

Format placeholders:
    {pingdom} pingdom response times

Color options:
    color_bad: Site is down
    color_degraded: Latency exceeded max_latency

Requires:
    requests: https://pypi.python.org/pypi/requests

@author ultrabug
##################
# player_control #
##################
Control Audacious or VLC media player.

Provides an icon to control simple functions of audio/video players:
    - start (left click)
    - stop  (left click)
    - pause (middle click)

Configuration parameters:
    cache_timeout: how often to update in seconds (default 10)
    debug: enable verbose logging (bool) (default False)
    format: format of the output (default "{icon}")
    pause_icon: (default '❚❚')
    play_icon: (default '▶')
    stop_icon: (default '◼')
    supported_players: supported players (str) (comma separated list)
        (default 'audacious,vlc')
    volume_tick: percentage volume change on mouse wheel (int) (positive number
        or None to disable it) (default 1)

Format placeholders:
    {icon} an icon to control music/video players

@author Federico Ceratto &lt;federico.ceratto@gmail.com&gt;, rixx
@license BSD
############
# pomodoro #
############
Use Pomodoro technique to get things done easily.

Button 1 starts/pauses countdown.
Button 2 switch Pomodoro/Break.
Button 3 resets timer.

Configuration parameters:
    display_bar: display time in bars when True, otherwise in seconds
        (default False)
    format: define custom time format. See placeholders below (default '{ss}')
    format_active: format to display when timer is active
        (default 'Pomodoro [{format}]')
    format_break: format to display during break
        (default 'Break #{breakno} [{format}]')
    format_break_stopped: format to display during a break that is stopped
        (default 'Break #{breakno} ({format})')
    format_separator: separator between minutes:seconds (default ':')
    format_stopped: format to display when timer is stopped
        (default 'Pomodoro ({format})')
    num_progress_bars: number of progress bars (default 5)
    pomodoros: specify a number of pomodoros (intervals) (default 4)
    sound_break_end: break end sound (file path) (requires pyglet
        or pygame) (default None)
    sound_pomodoro_end: pomodoro end sound (file path) (requires pyglet
        or pygame) (default None)
    sound_pomodoro_start: pomodoro start sound (file path) (requires pyglet
        or pygame) (default None)
    timer_break: normal break time (seconds) (default 300)
    timer_long_break: long break time (seconds) (default 900)
    timer_pomodoro: pomodoro time (seconds) (default 1500)

Format placeholders:
    {bar} display time in bars
    {breakno} current break number
    {ss} display time in total seconds (1500)
    {mm} display time in total minutes (25)
    {mmss} display time in (hh-)mm-ss (25:00)

Color options:
    color_bad: Pomodoro not running
    color_degraded: Pomodoro break
    color_good: Pomodoro active

Examples:
```
pomodoro {
    format = "{mmss} {bar}"
}
```

@author Fandekasp (Adrien Lemaire), rixx, FedericoCeratto, schober-ch, ricci
##################
# process_status #
##################
Display status of a process on your system.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default '{icon}')
    full: match against the full command line (default False)
    icon_off: show this if a process is not running (default '■')
    icon_on: show this if a process is running (default '●')
    process: specify a process name to use (default None)

Format placeholders:
    {icon} process icon
    {process} process name

Color options:
    color_bad: Not running
    color_good: Running

@author obb, Moritz Lüdecke
###########
# rainbow #
###########
Add color cycling fun to your i3bar.

This is the most pointless yet most exciting module you can imagine.

It allows color cycling of modules. Imagine the joy of having the current time
change through the colors of the rainbow.

If you were completely insane you could also use it to implement the i3bar
equivalent of the <blink> tag and cause yourself endless headaches and the
desire to vomit.

The color for the contained module(s) is changed and cycles through your chosen
gradient by default this is the colors of the rainbow.  This module will
increase the amount of updates that py3status needs to do so should be used
sparingly.

Configuration parameters:
    cycle_time: How often we change this color in seconds
        (default 1)
    force: If True then the color will always be set.  If false the color will
        only be changed if it has not been set by a module.
        (default False)
    format: display format for this module (default '{output}')
    gradient: The colors we will cycle through, This is a list of hex values
        *(default [ '#FF0000', '#FFFF00', '#00FF00', '#00FFFF',
        '#0000FF', '#FF00FF', '#FF0000', ])*
    multi_color: If True then each module the rainbow contains will be colored
        differently (default True)
    steps: Number of steps between each color in the gradient
        (default 10)

Format placeholders:
    {output} rainbow output

Examples:
```
# show time colorfully
order += "rainbow time"
rainbow time {
    time {}
}

# blinking text black/white
order += "rainbow blink_time"
rainbow blink_time {
    gradient = [
        '#FFFFFF',
        '#000000',
    ]
    steps = 1
    time {}
}
```

@author tobes
################
# rate_counter #
################
Display time spent and calculate the price of your service.

Configuration parameters:
    cache_timeout: how often to update in seconds (default 5)
    config_file: file path to store the time already spent
        and restore it the next session
        (default '~/.i3/py3status/counter-config.save')
    format: output format string
        (default 'Time: {days} day {hours}:{mins:02d} Cost: {total}')
    format_money: output format string
        (default '{price}$')
    hour_price: your price per hour (default 30)
    tax: tax value (1.02 = 2%) (default 1.02)

Format placeholders:
    {days} The number of whole days in running timer
    {hours} The remaining number of whole hours in running timer
    {mins} The remaining number of whole minutes in running timer
    {secs} The remaining number of seconds in running timer
    {subtotal} The subtotal cost (time * rate)
    {tax} The tax cost, based on the subtotal cost
    {total} The total cost (subtotal + tax)
    {total_hours} The total number of whole hours in running timer
    {total_mins} The total number of whole minutes in running timer

format_money placeholders:
    {price} numeric value of money

Color options:
    color_running: Running, default color_good
    color_stopped: Stopped, default color_bad

@author Amaury Brisou &lt;py3status AT puzzledge.org&gt;
##################
# rss_aggregator #
##################
Display unread feeds in your favorite RSS aggregator.

Configuration parameters:
    aggregator: feed aggregator used. Supported values are `owncloud` and `ttrss`.
        Other aggregators might be supported in future releases. Contributions are
        welcome. (default 'owncloud')
    cache_timeout: how often to run this check (default 60)
    feed_ids: list of IDs of feeds to watch, see note below (default [])
    folder_ids: list of IDs of folders ro watch (default [])
    format: format to display (default 'Feed: {unseen}')
    password: login password (default None)
    server: aggregator server to connect to (default 'https://yourcloudinstance.com')
    user: login user (default None)

Format placeholders:
    {unseen} sum of numbers of unread feed elements

Color options:
    color_new_items: text color when there is new items (default color_good)
    color_error: text color when there is an error (default color_bad)

Requires:
    requests: python module from pypi https://pypi.python.org/pypi/requests

Notes:
        You can also decide to check only for specific feeds or folders of feeds.
        To use this feature, you have to first get the IDs of those feeds or
        folders. You can get those IDs by clicking on the desired feed or folder
        and watching the URL.

    For OwnCloud/NextCloud with News application:
    https://yourcloudinstance.com/index.php/apps/news/#/items/feeds/FEED_ID
    https://yourcloudinstance.com/index.php/apps/news/#/items/folders/FOLDER_ID

    For Tiny Tiny RSS 1.6 or newer:
    https://yourttrssinstance.com/index.php#f=FEED_ID&amp;c=0
    https://yourttrssinstance.com/index.php#f=FOLDER_ID&amp;c=1

    If both feeds list and folders list are left empty, all unread feed items
    will be counted. You may use both feeds list and folders list, but given
    feeds shouldn't be included in given folders, else unread count number
    behavior is unpredictable. Same warning when aggregator allows subfolders:
    the folders list shouldn't include a folder and one of its subfolder.

@author raspbeguy
######
# rt #
######
Display number of ongoing tickets from RT queues.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 300)
    db: database to use (default '')
    format: see placeholders below (default 'general: {General}')
    host: database host to connect to (default '')
    password: login password (default '')
    threshold_critical: set bad color above this threshold (default 20)
    threshold_warning: set degraded color above this threshold (default 10)
    timeout: timeout for database connection (default 5)
    user: login user (default '')

Format placeholders:
    {YOUR_QUEUE_NAME} number of ongoing RT tickets (open+new+stalled)

Color options:
    color_bad: Exceeded threshold_critical
    color_degraded: Exceeded threshold_warning

Requires:
        PyMySQL: https://pypi.org/project/PyMySQL/
        or
        MySQL-python: https://pypi.org/project/MySQL-python/

It features thresholds to colorize the output and forces a low timeout to
limit the impact of a server connectivity problem on your i3bar freshness.

@author ultrabug
##############
# scratchpad #
##############
Display number of scratchpad windows and urgency hints.

Configuration parameters:
    cache_timeout: refresh interval for i3-msg or swaymsg (default 5)
    format: display format for this module
        (default "⌫ [\?color=scratchpad {scratchpad}]")
    thresholds: specify color thresholds to use
        (default [(0, "darkgray"), (1, "violet")])

Format placeholders:
    {scratchpad} number of scratchpads
    {urgent} number of urgent scratchpads

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Optional:
    i3ipc: an improved python library to control i3wm and sway

Examples:
```
# hide zero scratchpad
scratchpad {
    format = '[\?not_zero ⌫ [\?color=scratchpad {scratchpad}]]'
}

# hide non-urgent scratchpad
scratchpad {
    format = '[\?not_zero ⌫ {urgent}]'
}

# bring up scratchpads on clicks
scratchpad {
    on_click 1 = 'scratchpad show'
}

# add more colors
scratchpad {
    thresholds = [
       (0, "darkgray"), (1, "violet"), (2, "deepskyblue"), (3, "lime"),
       (4, "yellow"), (5, "orange"), (6, "red"), (7, "tomato"),
    ]
}
```

@author shadowprince (counter), cornerman (async)
@license Eclipse Public License (counter), BSD (async)
##############
# screenshot #
##############
Take screenshots and upload them to a given server.

Configuration parameters:
    file_length: generated file_name length (default 4)
    format: display format for this module
        (default '\?color=good [{basename}|\?show SHOT]')
    save_path: Directory where to store your screenshots (default '~/Pictures')
    screenshot_command: the command used to generate the screenshot
        (default 'gnome-screenshot -f')
    upload_path: the remote path where to push the screenshot (default None)
    upload_server: your server address (default None)
    upload_user: your ssh user (default None)

Format placeholders:
    {basename} generated basename, eg qs60.jpg

Examples:
```
# push screenshots to a server
screenshot {
    save_path = "~/Pictures/"
    upload_user = "erol"
    upload_server = "puzzledge.org"
    upload_path = "/files"

    # scp $HOME/Pictures/$UUID.jpg erol@puzzledge.org:/files
}
```

@author Amaury Brisou &lt;py3status AT puzzledge.org&gt;
##########
# scroll #
##########
Scroll modules.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 1)
    length: specify a length of characters to scroll (default 25)

Format placeholders:
    {output} output

@author farnoy
###########
# selinux #
###########
Display SELinux state.

This module displays the state of SELinux on your machine:
        Enforcing (good), Permissive (degraded), or Disabled (bad).

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default 'SELinux: {state}')
    state_disabled: show when no SELinux policy is loaded.
        (default 'disabled')
    state_enforcing: show when SELinux security policy is enforced.
        (default 'enforcing')
    state_permissive: show when SELinux prints warnings instead of enforcing.
        (default 'permissive')

Format placeholders:
    {state} SELinux state

Color options:
    color_bad: Enforcing
    color_degraded: Permissive
    color_good: Disabled

Requires:
    libselinux-python: SELinux python bindings for libselinux

@author bstinsonmhk
@license BSD
############
# spaceapi #
############
Display status of a given hackerspace.

Configuration parameters:
    button_url: mouse button to open URL sent in space's API (default 3)
    cache_timeout: refresh interval for this module (default 60)
    format: display format for this module (default '{state}[ {lastchanged}]')
    format_lastchanged: display format for time (default 'since %H:%M')
    state_closed: show when hackerspace is closed (default 'closed')
    state_open: show when hackerspace is open (default 'open')
    url: specify JSON URL of a hackerspace to retrieve from
        (default 'https://status.chaospott.de/status.json')

Format placeholders:
    {state} Hackerspace state
    {lastchanged} Time

format_lastchanged conversion:
        '%' Strftime characters to be translated

Color options:
    color_closed: Space closed, defaults to color_bad
    color_open: Space open, defaults to color_good

@author timmszigat
@license WTFPL &lt;http://www.wtfpl.net/txt/copying/&gt;
#############
# speedtest #
#############
Perform a bandwidth test with speedtest-cli.

Use middle-click to start the speed test.

Configuration parameters:
    button_share: mouse button to share an URL (default None)
    format: display format for this module
        *(default "speedtest[\?if=elapsed&amp;color=elapsed_time  "
        "{elapsed_time}s][ [\?color=download ↓{download}Mbps] "
        "[\?color=upload ↑{upload}Mbps]]")*
    thresholds: specify color thresholds to use
        *(default {"upload": [(0, "violet")], "ping": [(0, "#fff381")],
        "download": [(0, "cyan")], "elapsed_time": [(0, "#1cbfff")]})*

Control placeholders:
    {elapsed}          elapsed time state, eg False, True

Format placeholders:
    {bytes_sent}       bytes sent during test (in MB), eg 52.45
    {bytes_received}   bytes received during test (in MB), eg 70.23
    {client_country}   client country code, eg FR
    {client_ip}        client ip, eg 78.194.13.7
    {client_isp}       client isp, eg Free SAS
    {client_ispdlavg}  client isp download average, eg 0
    {client_isprating} client isp rating, eg 3.7
    {client_ispulavg}  client isp upload average, eg 0
    {client_lat}       client latitude, eg 48.8534
    {client_loggedin}  client logged in, eg 0
    {client_lon}       client longitude, eg 2.3487999999999998
    {client_rating}    client rating, eg 0
    {download}         download speed (in MB), eg 20.23
    {elapsed_time}     elapsed time since speedtest start
    {ping}             ping time in ms to speedtest server
    {server_cc}        server country code, eg FR
    {server_country}   server country, eg France
    {server_d}         server distance, eg 2.316599376968091
    {server_host}      server host, eg speedtest.telecom-paristech.fr:8080
    {server_id}        server id, eg 11977
    {share}            share, eg share url
    {timestamp}        timestamp, eg 2018-08-30T16:27:25.318212Z
    {server_lat}       server latitude, eg 48.8742
    {server_latency}   server latency, eg 8.265
    {server_lon}       server longitude, eg 2.3470
    {server_name}      server name, eg Paris
    {server_sponsor}   server sponsor, eg Télécom ParisTech
    {server_url}       server url, eg http://speedtest.telecom-paristech...
    {upload}           upload speed (in MB), eg 20.23

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    speedtest-cli: Command line interface for testing Internet bandwidth

Examples:
```
# show detailed elapsed_time|download/upload
speedtest {
    format = "speedtest[\?soft  ][\?if=elapsed [\?color=darkgray [time "
    format += "[\?color=elapsed_time {elapsed_time} s]]]|[\?color=darkgray "
    # format += "ping [\?color=ping {ping} ms] "
    format += "download [\?color=download {download}Mbps] "
    format += "upload [\?color=upload {upload}Mbps]]]"
}

# show everything
speedtest {
    format = "speedtest[\?soft  ][\?color=darkgray "
    format += "[time [\?color=elapsed_time {elapsed_time} s]][\?soft  ]"
    format += "[ping [\?color=ping {ping} ms] "
    format += "download [\?color=download {download}Mbps] "
    format += "upload [\?color=upload {upload}Mbps]]]"
}

# minimal
speedtest {
    format = "speedtest[\?soft  ][\?if=elapsed "
    format += "[\?color=elapsed_time {elapsed_time}]|"
    # format += "[\?color=ping {ping}] "
    format += "[[\?color=download {download}] [\?color=upload {upload}]]]"
}

# don't hide data on reset
speedtest {
    format = "speedtest[\?soft  ][\?color=darkgray time "
    format += "[\?color=elapsed_time {elapsed_time} s] "
    # format += "ping [\?color=ping {ping} ms] "
    format += "download [\?color=download {download}Mbps] "
    format += "upload [\?color=upload {upload}Mbps]]"
}

# don't hide data on reset, minimal
speedtest {
    format = "speedtest[\?soft  ][[\?color=elapsed_time {elapsed_time}] "
    # format += "[\?color=ping {ping}] "
    format += "[\?color=download {download}] [\?color=upload {upload}]]"
}
```

@author Cyril Levis (@cyrinux)
###########
# spotify #
###########
Display song currently playing in Spotify.

Configuration parameters:
    button_next: button to switch to next song (default None)
    button_play_pause: button to toggle play/pause (default None)
    button_previous: button to switch to previous song (default None)
    cache_timeout: how often to update the bar (default 5)
    format: see placeholders below (default '{artist} : {title}')
    format_down: define output if spotify is not running
        (default 'Spotify not running')
    format_stopped: define output if spotify is not playing
        (default 'Spotify stopped')
    sanitize_titles: whether to remove meta data from album/track title
        (default True)
    sanitize_words: which meta data to remove
        *(default ['bonus', 'demo', 'edit', 'explicit', 'extended',
        'feat', 'mono', 'remaster', 'stereo', 'version'])*

Format placeholders:
    {album} album name
    {artist} artiste name (first one)
    {playback} state of the playback: Playing, Paused
    {time} time duration of the song
    {title} name of the song

Color options:
    color_offline: Spotify is not running, defaults to color_bad
    color_paused: Song is stopped or paused, defaults to color_degraded
    color_playing: Song is playing, defaults to color_good

Requires:
    python-dbus: to access dbus in python
    spotify: a proprietary music streaming service

Examples:
```
spotify {
    button_next = 4
    button_play_pause = 1
    button_previous = 5
    format = "{title} by {artist} -> {time}"
    format_down = "no Spotify"
}
```

@author Pierre Guilbert, Jimmy Garpehäll, sondrele, Andrwe
#######
# sql #
#######
Display data stored in MariaDB, MySQL, sqlite3, and hopefully more.

Configuration parameters:
    cache_timeout: refresh cache_timeout for this module (default 10)
    database: specify database name to import (default None)
    format: display format for this module (default '{format_row}')
    format_row: display format for SQL rows (default None)
    format_separator: show separator if more than one (default ' ')
    parameters: specify connection parameters to use (default None)
    query: specify command to query a database (default None)
    thresholds: specify color thresholds to use (default [])

Format placeholders:
    {row} number of SQL rows
    {format_row} format for SQL rows
        Parameters can be placeholders too, eg {host}, {passd}

Format_row placeholders:
    {field} placeholders will have the value returned by the query for the field

Color thresholds:
    format:
        row: print a color based on the number of SQL rows
    format_row:
        field: print a color based on the value of `field` placeholder

Requires:
    mariadb: fast sql database server, drop-in replacement for mysql
    mysql-python: mysql support for python
    sqlite: a c library that implements an sql database engine

Examples:
```
# specify database name to import
sql {
    database = 'sqlite3'  # from sqlite3 import connect
    database = 'MySQLdb'  # from MySQLdb import connect
    database = '...'      # from ... import connect
}

# specify connection parameters to use
http://mysql-python.sourceforge.net/MySQLdb.html#functions-and-attributes
https://docs.python.org/3/library/sqlite3.html#module-functions-and-constants
sql {
    name = 'MySQLdb'
    format = '{host} {passd} ...'
    parameters = {
        'host': 'host',
        'passwd': 'password',
        '...': '...',
    }
}

# specify command to query a database
sql {
    query = 'SHOW SLAVE STATUS'
    query = 'SELECT * FROM cal_todos'
    query = '...'
}

# display number of seconds behind master with MySQLdb
sql {
    database = 'MySQLdb'
    format_row = '\?color=seconds_behind_master {host} is '
    format_row += '[{seconds_behind_master}s behind|\?show master]'
    parameters = {
        'host': 'localhost',
        'passwd': '********'
    }
    query = 'SHOW SLAVE STATUS'
    thresholds = [
        (0, 'deepskyblue'), (100, 'good'), (300, 'degraded'), (600, 'bad')
    ]
}

# display thunderbird tasks with sqlite3
sql {
    database = 'sqlite3'
    format_row = '{title}'
    format_separator = ', '
    query = 'SELECT * FROM cal_todos'
    parameters = '~/.thunderbird/user.default/calendar-data/local.sqlite'
}
```

@author cereal2nd
@license BSD
#################
# static_string #
#################
Display static text.

Configuration parameters:
    format: display format for this module (default 'Hello, world!')

@author frimdo ztracenastopa@centrum.cz
###########
# sysdata #
###########
Display system RAM, SWAP and CPU utilization.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds (default 10)
    cpu_freq_unit: the unit of CPU frequency to use in report, case insensitive.
        ['kHz', 'MHz', 'GHz'] (default 'GHz')
    cpus: specify a list of CPUs to use (default ['cpu?*'])
    format: output format string
        *(default '[\?color=cpu_used_percent CPU: {cpu_used_percent}%], '
        '[\?color=mem_used_percent Mem: {mem_used}/{mem_total} '
        '{mem_total_unit} ({mem_used_percent}%)]')*
    format_cpu: display format for CPUs
        (default '\?color=used_percent {used_percent}%')
    format_cpu_separator: show separator if more than one (default ' ')
    mem_unit: the unit of memory to use in report, case insensitive.
        ['dynamic', 'KiB', 'MiB', 'GiB'] (default 'GiB')
    swap_unit: the unit of swap to use in report, case insensitive.
        ['dynamic', 'KiB', 'MiB', 'GiB'] (default 'GiB')
    temp_unit: unit used for measuring the temperature ('C', 'F' or 'K')
        (default '°C')
    thresholds: specify color thresholds to use
        (default [(0, "good"), (40, "degraded"), (75, "bad")])
    zone: Either a path in sysfs to CPU temperature sensor, or an lm_sensors thermal zone to use.
        If None try to guess CPU temperature
        (default None)

Format placeholders:
    {cpu_freq_avg} average CPU frequency across all cores
    {cpu_freq_max} highest CPU clock frequency
    {cpu_freq_unit} unit for frequency
    {cpu_temp} cpu temperature
    {cpu_used_percent} cpu used percentage
    {format_cpu} format for CPUs
    {load1} load average over the last minute
    {load5} load average over the five minutes
    {load15} load average over the fifteen minutes
    {mem_total} total memory
    {mem_total_unit} memory total unit, eg GiB
    {mem_used} used memory
    {mem_used_unit} memory used unit, eg GiB
    {mem_used_percent} used memory percentage
    {swap_total} total swap
    {swap_total_unit} swap total memory unit, eg GiB
    {swap_used} used swap
    {swap_used_unit} swap used memory unit, eg GiB
    {swap_used_percent} used swap percentage
    {temp_unit} temperature unit

format_cpu placeholders:
    {name} cpu name, eg cpu, cpu0, cpu1, cpu2, cpu3
    {used_percent} cpu used percentage, eg 88.99

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Examples:
```
# specify a list of cpus to use. see "grep cpu /proc/stat"
sysdata {
    cpus = []                # avg + all CPUs
    cpus = ['cpu']           # avg             # same as {cpu_used_percent}
    cpus = ['cpu0', 'cpu2']  # selective CPUs  # full
    cpus = ['cpu?*']         # all CPUs        # fnmatch (default)
}

# display per cpu percents
sysdata {
    format = "{format_cpu}"
    format_cpu = "{name} [\?color=used_percent {used_percent}%]"
}

# customize per cpu padding, precision, etc
sysdata {
    format = "CPU {format_cpu}"
    format_cpu = "[\?min_length=4 [\?color=used_percent {used_percent:.0f}%]]"
}

# display per cpu histogram
sysdata {
    format = "CPU Histogram [\?color=cpu_used_percent {format_cpu}]"
    format_cpu = "[\?if=used_percent>80 ⡇|[\?if=used_percent>60 ⡆"
    format_cpu += "|[\?if=used_percent>40 ⡄|[\?if=used_percent>20 ⡀"
    format_cpu += "|⠀]]]]"
    format_cpu_separator = ""
    thresholds = [(0, "good"), (60, "degraded"), (80, "bad")]
    cache_timeout = 1
}
```

@author Shahin Azad <ishahinism at Gmail&gt;, shrimpza, guiniol, JackDoan &lt;me at jackdoan dot com>, farnoy
###########
# systemd #
###########
Display status of a service on your system.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module (default '\?if=!hide {unit}: {status}')
    hide_extension: suppress extension of the systemd unit (default False)
    hide_if_default: suppress the output if the systemd unit is in default state
        'off' the output is never suppressed
        'on' the output is suppressed if the unit is (enabled and active)
        or (disabled and inactive)
        'active' the output is suppressed if the unit is active
        'inactive' the output is suppressed if the unit is inactive
        (default 'off')
    unit: specify the systemd unit to use (default 'dbus.service')
    user: specify if this is a user service (default False)

Format placeholders:
    {unit} unit name, eg sshd.service
    {status} unit status, eg active, inactive, not-found

Color options:
    color_good: unit active
    color_bad: unit inactive
    color_degraded: unit not-found

Requires:
    pydbus: pythonic dbus library

Examples:
```
# show the status of vpn service
# left click to start, right click to stop
systemd vpn {
    unit = 'vpn.service'
    on_click 1 = 'exec sudo systemctl start vpn'
    on_click 3 = 'exec sudo systemctl stop vpn'
}
```

@author Adrian Lopez &lt;adrianlzt@gmail.com&gt;
@license BSD
#############################
# systemd_suspend_inhibitor #
#############################
Turn on and off systemd suspend inhibitor.

Configuration parameters:
    format: display format for this module
        (default '[\?color=state SUSPEND [\?if=state OFF|ON]]')
    lock_types: specify state to inhibit, comma separated list
        https://www.freedesktop.org/wiki/Software/systemd/inhibit/
        (default ['handle-lid-switch', 'idle', 'sleep'])
    thresholds: specify color thresholds to use
        (default [(True, 'bad'), (False, 'good')])

Format placeholders:
    {state} systemd suspend inhibitor state, eg True, False

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

@author Cyrinux https://github.com/cyrinux
@license BSD
###############
# taskwarrior #
###############
Display tasks currently running in taskwarrior.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    filter: specify one or more criteria to use (default 'status:pending')
    format: display format for this module (default '{descriptions}')

Format placeholders:
    {descriptions} descriptions of active tasks
    {tasks} number of active tasks

Requires
    task: https://taskwarrior.org/download/

@author James Smith https://jazmit.github.io
@license BSD
#####################
# thunderbird_todos #
#####################
Display number of todos and more for Thunderbird.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 60)
    format: display format for this module (default '{format_todo}')
    format_datetime: specify strftime formatting to use (default {})
    format_separator: show separator if more than one (default ' ')
    format_todo: display format for todos
        (default '\?if=!todo_completed {title}')
    profile: specify a profile path, otherwise first available profile
        eg '~/.thunderbird/abcd1234.default' (default None)
    sort: specify a tuple, eg ('placeholder_name', reverse_boolean)
        to sort by; excluding placeholder indexes (default ())
    thresholds: specify color thresholds to use (default [])

Format placeholders:
    {todo_total}        eg 5
    {todo_completed}    eg 2
    {todo_incompleted}  eg 3
    {format_todo}       format for todos

format_todo placeholders:
    {index_total}       eg 1, 2, 3
    {index_completed}   eg 1, 2, 3
    {index_incompleted} eg 1, 2, 3
    {alarm_last_ack}    eg None, 1513291952000000
    {cal_id}            eg 966bd855-5e71-4168-8072-c98f244ed825
    {flags}             eg 4, 276
    {ical_status}       eg None, IN-PROCESS, COMPLETED
    {id}                eg 87e9bfc9-eaad-4aa6-ad5f-adbf6d7a11a5
    {last_modified}     eg 1513276147000000
    {offline_journal}   eg None
    {priority}          eg None, # None=None, 0=None, 1=High, 5=Normal, 9=Low
    {privacy}           eg None, CONFIDENTIAL
    {recurrence_id}     eg None
    {recurrence_id_tz}  eg None, UTC
    {time_created}      eg 1513276147000000
    {title}             eg New Task
    {todo_complete}     eg None
    {todo_completed}    eg None, 1513281528000000
    {todo_completed_tz} eg None, UTC
    {todo_due}          eg None, 1513292400000000
    {todo_due_tz}       eg None, America/Chicago
    {todo_entry}        eg None, 1513292400000000
    {todo_entry_tz}     eg None, America/Chicago
    {todo_stamp}        eg 1513276147000000

format_datetime placeholders:
        KEY: alarm_last_ack, last_modified, time_created, todo,
        todo_completed, todo_entry, todo_stamp
        VALUE: % strftime characters to be translated, eg '%b %d' ----&gt; 'Dec 14'
        SEE EXAMPLE BELOW: "show incompleted titles with last modified time"

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    thunderbird: standalone mail and news reader

Examples:
```
# show number of incompleted titles
thunderbird_todos {
    format = '{todo_incompleted} incompleted todos'
}

# show rainbow number of incompleted titles
thunderbird_todos {
    format = '\?color=todo_incompleted {todo_incompleted} todos'
    thresholds = [
        (1, '#bababa'), (2, '#ffb3ba'), (3, '#ffdfba'), (4, '#ffffba'),
        (5, '#baefba'), (6, '#baffc9'), (7, '#bae1ff'), (8, '#bab3ff')
    ]
}

# show rainbow incompleted titles
thunderbird_todos {
    format_todo = '\?if=!todo_completed&color=index_incompleted {title}'
    thresholds = [
        (1, '#bababa'), (2, '#ffb3ba'), (3, '#ffdfba'), (4, '#ffffba'),
        (5, '#baefba'), (6, '#baffc9'), (7, '#bae1ff'), (8, '#bab3ff')
    ]
}

# show incompleted titles with last modified time
thunderbird_todos {
    format_todo = '\?if=!todo_completed {title} {last_modified}'
    format_datetime = {
        'last_modified': '\?color=degraded last modified %-I:%M%P'
    }
}

# show 'No todos'
thunderbird_todos {
    format = '{format_todo}|No todos'
}

# show completed titles and incompleted titles
thunderbird_todos {
    format_todo = '\?if=todo_completed&color=good {title}|\?color=bad {title}'
}

# make todo blocks
thunderbird_todos {
    format = 'TODO {format_todo}'
    format_todo = '\?if=todo_completed&color=good ▰|\?color=bad ▰'
    format_separator = ''
}

# display incompleted titles with any priority
thunderbird_todos {
    format_todo = '\?if=!todo_completed [\?if=priority>0 {title}]'
}

# colorize titles based on priorities
thunderbird_todos {
    format_todo = '\?if=!todo_completed [\?color=priority {title}]'
    thresholds = [(0, None), (1, 'red'), (5, None), (9, 'deepskyblue')]
}

# sort todos
thunderbird_todos {
    sort = ('last_modified', True) # sort by modified time: recent first
    sort = ('priority', True)      # sort by priority: high to low
    sort = ('title', False)        # sort by title: ABC to abc
}

# add your snippets here
thunderbird_todos {
    format = '...'
}
```

@author mrt-prodz, lasers
#########
# timer #
#########
A simple countdown timer.

This is a very basic countdown timer.  You can change the timer length as well
as pausing, restarting and resetting it.  Currently this is more of a demo of a
composite.

Each part of the timer can be changed independently hours, minutes, seconds using
mouse buttons 4 and 5 (scroll wheel).
Button 1 starts/pauses the countdown.
Button 2 resets timer.

Configuration parameters:
    format: display format for this module (default 'Timer {timer}')
    sound: play sound file path when the timer ends (default None)
    time: number of seconds to start countdown with (default 60)

Format placeholders:
    {timer} display hours:minutes:seconds

@author tobes
###############
# timewarrior #
###############
Track your time with Timewarrior.

Timewarrior is a time tracking utility that offers simple stopwatch features
as well as sophisticated calendar-base backfill, along with flexible reporting.
See https://taskwarrior.org/docs/timewarrior for more information.

Configuration parameters:
    cache_timeout: refresh interval for this module, otherwise auto
        (default None)
    filter: specify interval and/or tag to filter (default '1day')
    format: display format for this module
        (default '[Timew {format_time}]|No Timew')
    format_datetime: specify strftime characters to format (default {})
    format_duration: display format for time duration
        (default '\?not_zero [{days}d ][{hours}:]{minutes}:{seconds}')
    format_tag: display format for tags (default '\?color=state_tag {name}')
    format_tag_separator: show separator if more than one (default ' ')
    format_time: display format for tracked times
        (default '[\?color=state_time [{format_tag} ]{format_duration}]')
    format_time_separator: show separator if more than one (default ' ')
    thresholds: specify color thresholds to use
        *(default {'state_tag': [(0, 'darkgray'), (1, 'darkgray')],
        'state_time': [(0, 'darkgray'), (1, 'degraded')]})*

Format placeholders:
    {format_time} format for tracked times
    {tracking} time tracking state, eg False, True

format_time placeholders:
    {state} time tracking state, eg False, True
    {format_tag} format for tags
    {format_duration} format for time duration
    {start} start date, eg 20171021T010203Z
    {end} end date, eg 20171021T010203Z

format_tag placeholders:
    {name} tag name, eg gaming, studying, gardening

format_datetime placeholders:
    key: start, end
    value: strftime characters, eg '%b %d' ----&gt; 'Oct 06'

format_duration placeholders:
    {days} days
    {hours} hours
    {minutes} minutes
    {seconds} seconds

Color thresholds:
    format_time:
        state_time: print color based on the state of time tracking
    format_tag:
        state_tag:  print color based on the state of time tracking

Requires:
    timew: feature-rich time tracking utility

Recommendations:
        We can refresh a module using `py3-cmd` command.
        An excellent example of using this command in a function.

    ```
    ~/.{bash,zsh}{rc,_profile}
    ---------------------------
    function timew () {
        command timew "$@" && py3-cmd refresh timewarrior
    }
    ```

    With this, you can consider giving `cache_timeout` a much larger number,
    eg 3600 (an hour), so the module does not need to be updated that often.

Examples:
```
# show times matching the filter, see documentation for more filters
timewarrior {
    filter = ':day'           # filter times not in 24 hours of current day
    filter = '12hours'        # filter times not in 12 hours of current time
    filter = '5min'           # filter times not in 5 minutes of current time
    filter = '1sec'           # filter times not in 1 second of current time
    filter = '5pm to 11:59pm  # filter times not in 5pm to 11:59pm range
}

# intervals
timewarrior {
    # if you are printing other intervals too with '1day' filter or so,
    # then you may want to add this too for better bar readability
    format_time_separator = ', '

    # you also can change the thresholds with different colors
    thresholds = {
        'state_tag': [(0, 'darkgray'), (1, 'degraded')],
        'state_time': [(0, 'darkgray'), (1, 'degraded')],
    }
}

# cache_timeout
timewarrior {
    # auto refresh every 10 seconds when there is no active time tracking
    # auto refresh every second when there is active time tracking
    cache_timeout = None

    # refresh every minute when there is no active time tracking
    # refresh every second when there is active time tracking
    cache_timeout = 60

    # explicit refresh every 20 seconds when there is no active time tracking
    # explicit refresh every 5 seconds when there is active time tracking
    cache_timeout = (20, 5)
}

# add your snippets here
timewarrior {
    format = "..."
}
```

@author lasers
############
# tor_rate #
############
Display transfer rates of a tor instance.

Configuration parameters:
    cache_timeout: An integer specifying the cache life-time of the modules
        output in seconds (default 2)
    control_address: The address on which the Tor daemon listens for control
        connections (default "127.0.0.1")
    control_password: The password to use for the Tor control connection
        (default None)
    control_port: The port on which the Tor daemon listens for control
        connections (default 9051)
    format: A string describing the output format for the module
        (default "↑ {up} ↓ {down}")
    format_value: A string describing how to format the transfer rates
        (default "[\?min_length=12 {rate:.1f} {unit}]")
    hide_socket_errors: Hide errors connecting to Tor control socket
        (default False)
    rate_unit: The unit to use for the transfer rates
        (default "B/s")
    si_units: A boolean value selecting whether or not to use SI units
        (default False)

Format placeholders:
    {down} The incoming transfer rate
    {up} The outgoing transfer rate

format_value placeholders:
    {rate} The current transfer-rate's value
    {unit} The current transfer-rate's unit

Requires:
    stem: python controller library for tor https://pypi.org/project/stem

Examples:
```
tor_rate {
    cache_timeout = 10
    format = "IN: {down} | OUT: {up}"
    control_port = 1337
    control_password = "TertiaryAdjunctOfUnimatrix01"
    si_units = True
}
```

@author Felix Morgner &lt;felix.morgner@gmail.com&gt;
@license 3-clause-BSD
################
# transmission #
################
Display number of torrents and more.

Configuration parameters:
    arguments: additional arguments for the transmission-remote (default None)
    button_next: mouse button to switch next torrent (default None)
    button_previous: mouse button to switch previous torrent (default None)
    button_run: mouse button to run the command on current torrent
        (default [(1, '--start'), (2, '--verify'), (3, '--stop')])
    cache_timeout: refresh interval for this module (default 20)
    format: display format for this module (default '{format_torrent}')
    format_separator: show separator if more than one (default ' ')
    format_torrent: display format for torrents
        (default '[\?if=is_focused&amp;color=bad X] {status} {id} {name} {done}%')
    thresholds: specify color thresholds to use (default [])

Format placeholders:
    {torrent} number of torrents
    {format_torrent} format for torrents
    {up} summary up traffic
    {down} summary down traffic
    {have} summary download

format_torrent placeholders:
    {index} torrent index, eg 1
    {id} torrent id, eg 2
    {done} torrent percent, eg 100%
    {have} torrent download, 253 KB
    {eta} torrent estimated time, eg Done, 1 min, etc
    {up} torrent up traffic
    {down} torrent down traffic
    {ratio} torrent seed ratio
    {status} torrent status, eg Idle, Downloading, Stopped, Verifying, etc
    {name} torrent name, eg py3status-3.8.tar.gz

Color options:
    color_bad: current torrent

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    transmission-cli:
        fast, easy, and free bittorrent client (cli tools, daemon, web client)

Examples:
```
# add arguments
transmission {
    # We use 'transmission-remote --list'
    # See `transmission-remote --help' for more information.
    # Not all of the arguments will work here.
    arguments = '--auth username:password --port 9091'
}
# see 'man transmission-remote' for more buttons
transmission {
    button_run = [
        (1, '--start'),
        (2, '--verify'),
        (3, '--stop'),
        (8, '--remove'),
        (9, '--exit'),
    ]
}

# open web-based transmission client
transmission {
    on_click 1 = 'exec xdg-open http://username:password@localhost:9091'
}

# add buttons
transmission {
    button_next = 5
    button_previous = 4
}

# see 'man transmission-remote' for more buttons
transmission {
    # specify a script to run when a torrent finishes
    on_click 9 = 'exec transmission-remote --torrent-done-script ~/file'

    # use the alternate limits?
    on_click 9 = 'exec transmission-remote --alt-speed'
    on_click 10 = 'exec transmission-remote --no-alt-speed'
}

# show summary statistcs - up, down, have
transmission {
    format = '{format_torrent}'
    format += '[\?color=#ffccff [\?not_zero  Up:{up}]'
    format += '[\?not_zero  Down:{down}][\?not_zero  Have:{have}]]'
}

# add a format that sucks less than the default plain format
transmission {
    format_torrent = '[\?if=is_focused&color=bad X ]'
    format_torrent += '[[\?if=status=Idle&color=degraded {status}]'
    format_torrent += '|[\?if=status=Stopped&color=bad {status}]'
    format_torrent += '|[\?if=status=Downloading&color=good {status}]'
    format_torrent += '|[\?if=status=Verifying&color=good {status}]'
    format_torrent += '|\?color=degraded {status}]'
    format_torrent += ' {name} [\?color=done {done}]'
}

# show percent thresholds
transmission {
    format_torrent = '{name} [\?color=done {done}]'
    thresholds = [(0, 'bad'), (1, 'degraded'), (100, 'good')]
}

# download the rainbow
transmission {
    format_torrent = '[\?if=is_focused&color=bad X ]'
    format_torrent += '{status} [\?color=index {name}] [\?color=done {done}%]'
    thresholds = {
        'done': [(0, '#ffb3ba'), (1, '#ffffba'), (100, '#baefba')],
        'index': [
            (1, '#ffb3ba'), (2, '#ffdfba'), (3, '#ffffba'),
            (4, '#baefba'), (5, '#baffc9'), (6, '#bae1ff'),
            (7, '#bab3ff')
        ]
    }
}
```

@author lasers
##########
# twitch #
##########
Display if a Twitch channel is currently streaming or not.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds
        (default 60)
    client_id: Your client id. Create your own key at https://dev.twitch.tv
        (default None)
    format: Display format when online
        (default "{display_name} is live!")
    format_offline: Display format when offline
        (default "{display_name} is offline.")
    stream_name: name of streamer(twitch.tv/<stream_name>)
        (default None)

Format placeholders:
    {display_name} streamer display name, eg Ultrabug

Color options:
    color_bad: Stream offline
    color_good: Stream is live

Client ID:
        Example settings when creating your app at https://dev.twitch.tv

    Name: <your_name>_py3status
    OAuth Redirect URI: https://localhost
    Application Category: Application Integration


@author Alex Caswell horatioesf@virginmedia.com
@license BSD
#########
# uname #
#########
Display system information.

Configuration parameters:
    format: display format for this module (default '{system} {release}')

Format placeholders:
    {system} system/OS name, e.g. 'Linux', 'Windows', or 'Java'
    {node} computer’s network name (may not be fully qualified!)
    {release} system’s release, e.g. '2.2.0' or 'NT'
    {version} system’s release version, e.g. '#3 on degas'
    {machine} machine type, e.g. 'x86_64'
    {processor} the (real) processor name, e.g. 'amdk6'

@author ultrabug (inspired by ndalliard)
##########
# uptime #
##########
Display system uptime.

Configuration parameters:
    format: display format for this module
        (default 'up {days} days {hours} hours {minutes} minutes')

Format placeholders:
    {decades} decades
    {years}   years
    {weeks}   weeks
    {days}    days
    {hours}   hours
    {minutes} minutes
    {seconds} seconds

    If you don't use a placeholder, its value will be carried over
    to the next placeholder. For example, an uptime of 1 hour 30 minutes
    will give you 90 if {minutes} or 1:30 if {hours}:{minutes}.

    You also can specify strftime characters to print system up since
    with or without placeholders. See `man strftime` for more information.

Examples:
```
# show uptime without zeroes
uptime {
    format = 'up [\?if=weeks {weeks} weeks ][\?if=days {days} days ]
        [\?if=hours {hours} hours ][\?if=minutes {minutes} minutes ]'
}

# show uptime in multiple formats using group module
group uptime {
    format = "up {output}"
    uptime {
        format = '[\?if=weeks {weeks} weeks ][\?if=days {days} days ]
            [\?if=hours {hours} hours ][\?if=minutes {minutes} minutes]'
    }
    uptime {
        format = '[\?if=weeks {weeks}w ][\?if=days {days}d ]
            [\?if=hours {hours}h ][\?if=minutes {minutes}m]'
    }
    uptime {
        format = '[\?if=days {days}, ][\?if=hours {hours}:]
            [\?if=minutes {minutes:02d}]'
    }
}

# specify strftime characters to display system up since
uptime {
    format = "{days}d {hours}:{minutes:02d}:{seconds:02d}"
    format += ", up since %Y-%m-%d %H:%M:%S"
}
```

@author Alexis "Horgix" Chotard &lt;alexis.horgix.chotard@gmail.com&gt;, Volkov "BabyWolf" Semjon &lt;Volkov.BabyWolf.Semjon@gmail.com&gt;
@license BSD
############
# usbguard #
############
Allow or Reject newly plugged USB devices using USBGuard.

Configuration parameters:
    format: display format for this module
        (default '{format_device}')
    format_button_allow: display format for allow button filter
        (default '\[Allow\]')
    format_button_reject: display format for reject button filter
        (default '\[Reject\]')
    format_device: display format for USB devices
        (default '{format_button_reject} [{name}|{usb_id}] {format_button_allow}')
    format_device_separator: show separator if more than one (default ' ')

Format placeholders:
    {device}                  number of USB devices
    {format_device}           format for USB devices

format_device:
    {format_button_allow}     button to allow the device
    {format_button_reject}    button to reject the device
    {id}                      eg 1, 2, 5, 6, 7, 22, 23, 33
    {policy}                  eg allow, block, reject
    {usb_id}                  eg 054c:0268
    {name}                    eg Poker II, PLAYSTATION(R)3 Controller
    {serial}                  eg 0000:00:00.0
    {port}                    eg usb1, usb2, usb3, 1-1, 4-1.2.1
    {interface}               eg 00:00:00:00 00:00:00 00:00:00
    {hash}                    eg ihYz60+8pxZBi/cm+Q/4Ibrsyyzq/iZ9xtMDAh53sng
    {parent_hash}             eg npSDT1xuEIOSLNt2RT2EbFrE8XRZoV29t1n7kg6GxXg

Requires:
    python-gobject: Python Bindings for GLib/GObject/GIO/GTK+
    usbguard: USB device authorization policy framework

@author @cyrinux, @maximbaz
@license BSD
###################
# velib_metropole #
###################
Display information about Velib Métropole stations.

Vélib' Métropole, https://en.wikipedia.org/wiki/Vélib'_Métropole, is a large-
scale public bicycle sharing system in Paris, France and surrounding cities.

Configuration parameters:
    button_next: mouse button to display next station (default 4)
    button_previous: mouse button to display previous station (default 5)
    cache_timeout: refresh interval for this module (default 60)
    format: display format for this module
        (default '{format_station}|No Velib')
    format_station: display format for stations
        *(default "{name} [\?if=state=Closed&amp;color=state {state} ]"
        "[\?color=greenyellow {bike}/{free_dock} ]"
        "[\?color=deepskyblue {ebike}/{free_edock}]")*
    stations: specify a list of station codes to use, find your
        station code at https://www.velib-metropole.fr/map
        (default [20043, 11014, 20012, 20014, 10042])
    thresholds: specify color thresholds to use
        (default [("Operative", "good"), ("Closed", "bad")])

Format placeholders:
    {format_station}      format for stations
    {station}             total number of stations, eg 12

format_station placeholders:
    {index}               index number, eg 1
    {bike}                number of available bike, eg 3
    {bike_overflow}       number of bike in overflow, eg 0
    {code}                code, eg 10042
    {credit_card}         credit card, eg no, yes
    {density_level}       density level, eg 1
    {dock}                number of dock, eg 0
    {due_date}            due date, eg 1527717600
    {ebike}               number of electric bike, eg 0
    {ebike_overflow}      overflow bike, eg 0
    {edock}               number of electric dock, eg 33
    {free_dock}           available bike places, eg 0
    {free_edock}          available electric bike places, eg 30
    {kiosk_state}         kiosk in working, eg no, yes
    {latitude}            latitude, eg 48.87242006305313
    {longitude}           longitude, eg 2.348395236282807
    {max_bike_overflow}   max overflow bike, eg 33
    {name}                name, eg Enghien - Faubourg Poissonnière
    {overflow}            support overflow, eg no, yes
    {overflow_activation} state of overflow support, eg no, yes
    {state}               state, eg Closed, Operative
    {type}                type, eg no, yes

Color thresholds:
    format:
        xxx: print a color based on the value of `xxx` placeholder
    format_station:
        xxx: print a color based on the value of `xxx` placeholder

@author Cyril Levis (@cyrinux)
##########
# vnstat #
##########
Display vnstat statistics.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 180)
    format: display format for this module (default '{total}')
    initial_multi: set to 1 to disable first bytes
        (default 1024)
    left_align: (default 0)
    multiplier_top: if value is greater, divide it with unit_multi and get
        next unit from units (default 1024)
    precision: (default 1)
    statistics_type: d for daily, m for monthly (default 'd')
    thresholds: thresholds to use for color changes (default [])
    unit_multi: value to divide if rate is greater than multiplier_top
        (default 1024)

Format placeholders:
    {down} download
    {total} total
    {up} upload

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    vnstat: a console-based network traffic monitor

Examples:
```
# colorize thresholds
vnstat {
    format = '[\?color=total {total}]'
    thresholds = [
        (838860800, "degraded"),  # 838860800 B -> 800 MiB
        (943718400, "bad"),       # 943718400 B -> 900 MiB
    ]
}
```

@author shadowprince
@license Eclipse Public License
#################
# volume_status #
#################
Volume control.

Configuration parameters:
    blocks: a string, where each character represents a volume level
        (default "_▁▂▃▄▅▆▇█")
    button_down: button to decrease volume (default 5)
    button_mute: button to toggle mute (default 1)
    button_up: button to increase volume (default 4)
    cache_timeout: how often we refresh this module in seconds.
        (default 10)
    card: Card to use. amixer supports this. (default None)
    channel: channel to track. Default value is backend dependent.
        (default None)
    command: Choose between "amixer", "pamixer" or "pactl".
        If None, try to guess based on available commands.
        (default None)
    device: Device to use. Defaults value is backend dependent
        (default None)
    format: Format of the output.
        (default '[\?if=is_input 😮|♪]: {percentage}%')
    format_muted: Format of the output when the volume is muted.
        (default '[\?if=is_input 😶|♪]: muted')
    is_input: Is this an input device or an output device?
        (default False)
    max_volume: Allow the volume to be increased past 100% if available.
        pactl and pamixer supports this. (default 120)
    thresholds: Threshold for percent volume.
        (default [(0, 'bad'), (20, 'degraded'), (50, 'good')])
    volume_delta: Percentage amount that the volume is increased or
        decreased by when volume buttons pressed.
        (default 5)

Format placeholders:
    {icon} Character representing the volume level,
        as defined by the 'blocks'
    {percentage} Percentage volume

Color options:
    color_muted: Volume is muted, if not supplied color_bad is used
        if set to `None` then the threshold color will be used.

Requires:
    alsa-utils: an alternative implementation of linux sound support
    pamixer: pulseaudio command-line mixer like amixer

Notes:
        If you are changing volume state by external scripts etc and
        want to refresh the module quicker than the i3status interval,
        send a USR1 signal to py3status in the keybinding.
        Example: killall -s USR1 py3status

Examples:
```
# Set thresholds to rainbow colors
volume_status {
    thresholds = [
        (0, "#FF0000"),
        (10, "#E2571E"),
        (20, "#FF7F00"),
        (30, "#FFFF00"),
        (40, "#00FF00"),
        (50, "#96BF33"),
        (60, "#0000FF"),
        (70, "#4B0082"),
        (80, "#8B00FF"),
        (90, "#FFFFFF")
    ]
}
```

@author <Jan T> &lt;jans.tuomi@gmail.com&gt;
@license BSD
##############
# vpn_status #
##############
Drop-in replacement for i3status run_watch VPN module.

Expands on the i3status module by displaying the name of the connected vpn
using pydbus. Asynchronously updates on dbus signals unless check_pid is True.

Configuration parameters:
    cache_timeout: How often to refresh in seconds when check_pid is True.
        (default 10)
    check_pid: If True, act just like the default i3status module.
        (default False)
    format: Format of the output.
        (default 'VPN: {name}|VPN: no')
    pidfile: Same as i3status pidfile, checked when check_pid is True.
        (default '/sys/class/net/vpn0/dev_id')

Format placeholders:
    {name} The name and/or status of the VPN.

Color options:
    color_bad: VPN connected
    color_good: VPN down

Requires:
    pydbus: Which further requires PyGi. Check your distribution's repositories.

@author Nathan Smith &lt;nathan AT praisetopia.org&gt;
##################
# wanda_the_fish #
##################
Display a fortune-telling, swimming fish.

Wanda has no use what-so-ever. It only takes up disk space and compilation time,
and if loaded, it also takes up precious bar space, memory, and cpu cycles.
Anybody found using it should be promptly sent for a psychiatric evaluation.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 0)
    format: display format for this module
        (default '{nomotion}[{fortune} ]{wanda}{motion}')
    fortune_timeout: refresh interval for fortune (default 60)

Format placeholders:
    {fortune} one of many aphorisms or vague prophecies
    {wanda} name of one of the most commonly kept freshwater aquarium fish
    {motion} biologically propelled motion through a liquid medium
    {nomotion} opposite behavior of motion to prevent modules from shifting

Optional:
    fortune-mod: the fortune cookie program from bsd games

Examples:
```
# disable motions when not in use
wanda_the_fish {
    format = '[\?if=fortune {nomotion}][{fortune} ]'
    format += '{wanda}[\?if=fortune {motion}]'
}

# no updates, no motions, yes fortunes, you click
wanda_the_fish {
    format = '[{fortune} ]{wanda}'
    cache_timeout = -1
}

# wanda moves, fortunes stays
wanda_the_fish {
    format = '[{fortune} ]{nomotion}{wanda}{motion}'
}

# wanda is swimming too fast, slow down wanda
wanda_the_fish {
    cache_timeout = 2
}
```

@author lasers
###############
# weather_owm #
###############
Display ultimately customizable weather.

This module allows you to specify an icon for nearly every weather scenario
imaginable. The default configuration options lump many of the icons into
a few groups, and due to the limitations of UTF-8, this is really as expressive
as it gets.

This module uses OpenWeatherMap API (https://openweathermap.org).

setting `location` or `city` allows you to specify the location for the weather
you want displaying.

Requires an API key for OpenWeatherMap (OWM), but the free tier allows you
enough requests/sec to get accurate weather even up to the minute.

I would highly suggest you install an additional font, such as the incredible
(and free!) Weather Icons font (https://erikflowers.github.io/weather-icons),
which has icons for most weather scenarios. But, this will still work with
the i3bar default font, Deja Vu Sans Mono font, which has Unicode support.
You can see the (limited) weather icon support within Unicode in the defaults.

For more information, see the documentation
(https://openweathermap.org/weather-conditions) on what weather conditions are
supported. See the configuration options for how to specify each weather icon.

Configuration parameters:
    api_key: Your OpenWeatherMap API key
        See https://openweathermap.org/appid. Required!
        (default None)
    cache_timeout: The time between API polling in seconds
        It is recommended to keep this at a higher value to avoid rate
        limiting with the API's.
        (default 1800)
    city: The city to display for location information. If set,
        implicitly disables the Geo API for determining city name.
        (default None)
    country: The country to display for location information. If set,
        implicitly disables the Geo API for determining country name.
        (default None)
    forecast_days: Number of days to include in the forecast, including today
        (regardless of the 'forecast_include_today' flag)
        (default 3)
    forecast_include_today: Include today in the forecast? (Boolean)
        (default False)
    format: How to display the weather
        This also dictates the type of forecast. The placeholders here refer to
        the format_[...] variables found below.
        Available placeholders:
        icon, city, clouds, rain, snow, wind, humidity, pressure,
        temperature, sunrise, sunset, main, description, forecast
        (default '{city} {icon} {temperature}[ {rain}], {description} {forecast}')
    format_clouds: Formatting for cloud coverage (percentage)
        Available placeholders:
        icon, coverage
        (default '{icon} {coverage}%')
    format_forecast: Formatting for future forecasts
        Available placeholders:
        See 'format'
        This is similar to the 'format' field, but contains information
        for future weather. Notably, this does not include information about
        sunrise or sunset times.
        (default '{icon}')
    format_forecast_separator: Separator between entries in the forecast
        (default ' ')
    format_humidity: Formatting for humidity (percentage)
        Available placeholders:
        icon, humidity
        (default '{icon} {humidity}%')
    format_pressure: Formatting for atmospheric pressure
        Available placeholders:
        icon, pressure, sea_level
        (default '{icon} {pressure} hPa')
    format_rain: Formatting for rain volume over the past 3 hours
        Available placeholders:
        icon, amount
        (default '[\?if=amount {icon} {amount:.0f} {unit}]')
    format_snow: Formatting for snow volume over the past 3 hours
        Available placeholders:
        icon, amount
        (default '[\?if=amount {icon} {amount:.0f} {unit}]')
    format_sunrise: Formatting for sunrise time
        Note that this format accepts strftime/strptime placeholders to populate
        the output with the time information.
        Available placeholders:
        icon
        (default '{icon} %-I:%M %p')
    format_sunset: Formatting for sunset time
        This format accepts strftime/strptime placeholders to populate the
        output with the time information.
        Available placeholders:
        icon
        (default '{icon} %-I:%M %p')
    format_temperature: Formatting for temperature
        Available placeholders:
        current, icon, max, min
        (default '{icon} [\?color=all {current:.0f}°{unit}]')
    format_wind: Formatting for wind degree and speed
        The 'gust' option represents the speed of wind gusts in the wind unit.
        Available placeholders:
        icon, degree, speed, gust
        (default '[\?if=speed {icon} {speed:.0f} {unit}]')
    icon_atmosphere: Icon for atmospheric conditions, like fog, smog, etc.
        (default '🌫')
    icon_cloud: Icon for clouds
        (default '☁')
    icon_extreme: Icon for extreme weather
        (default '⚠')
    icon_humidity: Icon for humidity
        (default '●')
    icon_pressure: Icon for pressure
        (default '◌')
    icon_rain: Icon for rain
        (default '🌧')
    icon_snow: Icon for snow
        (default '❄')
    icon_sun: Icon for sunshine
        (default '☼')
    icon_sunrise: Icon for sunrise
        (default '⇑')
    icon_sunset: Icon for sunset
        (default '⇓')
    icon_temperature: Icon for temperature
        (default '○')
    icon_thunderstorm: Icon for thunderstorms
        (default '⛈')
    icon_wind: Icon for wind or breeze
        (default '☴')
    icons: A dictionary relating weather code to icon
        See https://openweathermap.org/weather-conditions for a complete list
        of supported icons. This will fall-back to the listed icon if there is
        no specific icon present. However, options included here take precedent
        over the above 'icon_{...}' options.
        There are multiple ways to specify individual icons based on the id:
        * Use the key '601' to reference the condition with id = 601
        (snow)
        * Use the key '230_232' to reference a span of conditions
        inclusive, in this case conditions (230, 231, 232) (thunderstorm
        with drizzle)
        (default None)
    lang: An ISO 639-1 code for your language (two letters)
        (default 'en')
    location: A tuple of floats describing the desired weather location
        The tuple should follow the form (latitude, longitude), and if set,
        implicitly disables the Geo API for determining location.
        (default None)
    thresholds: Configure temperature colors based on limits
        The numbers specified inherit the unit of the temperature as configured.
        The default below is intended for Fahrenheit. If the set value is empty
        or None, the feature is disabled. You can specify this parameter using a
        dictionary:
        * Keys are names. You have the option of 'current', 'min', 'max',
        or 'all' to specify a threshold. The first three are tied to the
        various temperature values, the last sets the same threshold for
        all outputs. If both 'all' and one of the first three are set
        (lets say 'min' for this example), the threshold will default to
        be the value in 'min', not 'all'. This goes for any configuration
        * The values are lists of pairs, with temperature (in the
        configured unit) as the first and the color as the second
        * To use the thresholds color, place '\?color=all' in the
        formatting string for temperature, replacing 'all' with any of
        the valid threshold names for different coloring effects
        * To have smooth transitions between colors, consider setting the
        'gradients' configuration parameter to 'True', either in the
        global configuration, or in the module configuration!
        (default {'all': [(-100, '#0FF'), (0, '#00F'), (50, '#0F0'), (150, '#FF0')]})
    unit_rain: Unit for rain fall
        When specified, a unit may be any combination of upper and lower
        case, such as 'Ft', and still be considered valid as long as it is in
        the below options.
        Options:
        cm, ft, in, mm, m, yd
        (default 'in')
    unit_snow: Unit for snow fall
        Options:
        cm, ft, in, mm, m, yd
        (default 'in')
    unit_temperature: Unit for temperature
        Options:
        c, f, k
        (default 'F')
    unit_wind: Unit for wind speed
        Options:
        fsec, msec, mph, kmh
        (default 'mph')

Format placeholders:
    {icon} The icon associated with a formatting section
    format_clouds:
    {coverage} Cloud coverage percentage
    format_humidity:
    {humidity} Humidity percentage
    format_pressure:
    {pressure} Current atmospheric pressure in Pascals
    {sea_level} Sea-level atmospheric pressure in Pascals.
    format_rain:
    {amount} Rainfall in the specified unit
    {unit} The unit specified
    format_snow:
    {amount} Snowfall in the specified unit
    {unit} The unit specified
    format_temperature:
    {current} Current temperature
    {max} Maximum temperature in the configured unit
    {min} Minimum temperature
    {unit} The unit specified
    format_wind:
    {degree} Current wind heading
    {gust} Wind gusts speed in the specified unit
    {speed} Wind speed
    {unit} The unit specified
        format only:
    {city} The name of the city where the weather is
    {country} The name of the country where the weather is
    {forecast} Output of format_forecast
        format, format_forecast:
    {clouds} Output of format_clouds
    {description} Natural description of the current weather
    {humidity} Output of format_humidity
    {main} Short description of the current weather
    {pressure} Output of format_pressure
    {snow} Output of format_snow
    {sunrise} Output of format_sunrise
    {sunset} Output of format_sunset
    {temperature} Output of format_temperature
    {wind} Output of format_wind

Examples:
```
# change icons
weather_owm {
    api_key = <my api key>
    icons = {
        '200': "☔"
        '230_232': "🌧"
    }
}

# set a city
weather_owm {
    api_key = <my api key>
    city = 'London'
}

# set a location
weather_owm {
    api_key = <my api key>
    location = (48.9342, 2.3548)  # Saint-Denis
}
```

@author alexoneill
@licence MIT

##############
# whatismyip #
##############
Display public IP address and online status.

Configuration parameters:
    button_refresh: mouse button to refresh this module (default 2)
    button_toggle: mouse button to toggle between states (default 1)
    cache_timeout: how often we refresh this module in seconds (default 60)
    expected: define expected values for format placeholders,
        and use `color_degraded` to show the output of this module
        if any of them does not match the actual value.
        This should be a dict eg {'country': 'France'}
        (default None)
    format: available placeholders are {ip} and {country},
        as well as any other key in JSON fetched from `url_geo`
        (default '{ip}')
    hide_when_offline: hide the module output when offline (default False)
    icon_off: what to display when offline (default '■')
    icon_on: what to display when online (default '●')
    mode: default mode to display is 'ip' or 'status' (click to toggle)
        (default 'ip')
    url_geo: IP to check for geo location (must output json)
        (default 'https://ifconfig.co/json')

Format placeholders:
    {icon}        eg ●, ■
    {country}     eg France
    {country_iso} eg FR
    {ip}          eg 123.45.67.890
    {ip_decimal}  eg 1234567890
    {city}        eg Paris
        any other key in JSON fetched from `url_geo`

Color options:
    color_bad: Offline
    color_degraded: Output is unexpected (IP/country mismatch, etc.)
    color_good: Online

@author ultrabug, Cyril Levis (@cyrinux)
##########
# whoami #
##########
Display logged-in username.

Configuration parameters:
    format: display format for this module (default '{username}')

Format placeholders:
    {username} display current username

Inspired by i3 FAQ:
        https://faq.i3wm.org/question/1618/add-user-name-to-status-bar.1.html

@author ultrabug
########
# wifi #
########
Display WiFi bit rate, quality, signal and SSID using iw.

Configuration parameters:
    bitrate_bad: Bad bit rate in Mbit/s (default 26)
    bitrate_degraded: Degraded bit rate in Mbit/s (default 53)
    blocks: a string, where each character represents quality level
        (default "_▁▂▃▄▅▆▇█")
    cache_timeout: Update interval in seconds (default 10)
    device: specify name or MAC address of device to use, otherwise auto
        (default None)
    down_color: Output color when disconnected, possible values:
        "good", "degraded", "bad" (default "bad")
    format: Display format for this module
        (default 'W: {bitrate} {bitrate_unit} {signal_percent}% {ssid}|W: down')
    signal_bad: Bad signal strength in percent (default 29)
    signal_degraded: Degraded signal strength in percent (default 49)
    thresholds: specify color thresholds to use (default [])

Format placeholders:
    {bitrate} Display bitrate
    {bitrate_unit} Display bitrate unit
    {device} Display device name
    {freq_ghz} Network frequency in Ghz
    {freq_mhz} Network frequency in Mhz
    {icon} Character representing the quality based on bitrate,
        as defined by the 'blocks'
    {ip} Display IP address
    {signal_dbm} Display signal in dBm
    {signal_percent} Display signal in percent
    {ssid} Display SSID

Color options:
    color_bad: Signal strength signal_bad or lower
    color_degraded: Signal strength signal_degraded or lower
    color_good: Signal strength above signal_degraded

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    iw: cli configuration utility for wireless devices
    ip: only for {ip}. may be part of iproute2: ip routing utilities

Notes:
        Some distributions require commands to be run with privileges. You can
        give commands some root rights to run without a password by editing
        sudoers file, i.e., `sudo visudo`, and add a line that requires sudo.
        '<user> ALL=(ALL) NOPASSWD:/sbin/iw dev,/sbin/iw dev [a-z]* link'
        '<user> ALL=(ALL) NOPASSWD:/sbin/ip addr list [a-z]*'

@author Markus Weimar &lt;mail@markusweimar.de&gt;
@license BSD
##########
# window #
##########
Display window properties (i.e. title, class, instance).

Configuration parameters:
    cache_timeout: refresh interval for i3-msg or swaymsg (default 0.5)
    format: display format for this module (default "{title}")
    hide_title: hide title on containers with window title (default False)
    max_width: specify width to truncate title with ellipsis (default None)

Format placeholders:
    {class} window class
    {instance} window instance
    {title} window title

Optional:
    i3ipc: an improved python library to control i3wm and sway

Examples:
```
# show alternative instead of empty title
window_title {
    format = '{title}|♥'
}
```

@author shadowprince (counter), Anon1234 (async)
@license Eclipse Public License (counter), BSD (async)
########
# wwan #
########
Display WWANs, IP addresses, signals, properties and sms.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 5)
    format: display format for this module
        *(default '\?color=state WW: [\?if=state_name=connected '
        '({signal_quality_0}% at {m3gpp_operator_name}) '
        '[{format_ipv4}[\?soft  ]{format_ipv6}]|{state_name}]'
        '[ SMS {messages} [{format_message}]]')*
    format_ipv4: display format for ipv4 network (default '[{address}]')
    format_ipv6: display format for ipv6 network (default '[{address}]')
    format_message: display format for SMS messages
        (default '\?if=index&lt;2 {number} [\?max_length=10 {text}...]')
    format_message_separator: show separator if more than one (default ' ')
    format_notification: specify notification to use (default None)
    format_stats: display format for statistics (default '{duration_hms}')
    modem: specify a modem device to use, otherwise auto (default None)
    thresholds: specify color thresholds to use
        (default [(0, 'bad'), (11, 'good')])

Format placeholders:
    {access_technologies}           network speed, in bit, eg 192
    {access_technologies_name}      network speed names, eg LTE
    {current_bands}                 modem band, eg 1
    {current_bands_name}            modem band name, eg GSM/GPRS/EDGE 900 MHz
    {format_ipv4}                   format for ipv4 network config
    {format_ipv6}                   format for ipv6 network config
    {format_message}                format for SMS messages
    {format_stats}                  format for network connection statistics
    {interface_name}                network interface name, eg wwp0s20f0u2i12
    {m3gpp_registration_state_name} network registration state name, eg HOME
    {m3gpp_registration_state}      network registration state, eg 1
    {m3gpp_operator_code}           network operator code, eg 496
    {m3gpp_operator_name}           network operator name, eg Py3status Telecom
    {message}                       number of messages, eg 2
    {messages}                      total number of messages, eg 30
    {signal_quality_0}              signal quality percentage, eg 88
    {signal_quality_1}              signal quality refreshed, eg True/False
    {state}                         network state, eg 0, 7, 11
    {state_name}                    network state name, eg searching, connected

format_ipv4 placeholders:
    {address} ip address
    {dns1}    dns1
    {dns2}    dns2
    {gateway} gateway
    {mtu}     mtu
    {prefix}  netmask prefix

format_ipv6 placeholders:
    {address} ip address
    {dns1}    dns1
    {dns2}    dns2
    {gateway} gateway
    {mtu}     mtu
    {prefix}  netmask prefix

format_message placeholders:
    {index}   message index
    {text}    text received, eg: 'hello how are you?'
    {number}  contact number, eg: '+33601020304'

format_stats placeholders:
    {duration}     time since connected, in seconds, eg 171
    {duration_hms} time since connected, in [hh:]mm:ss, eg 02:51
    {tx_bytes}     transmit bytes
    {rx_bytes}     receive bytes

Color thresholds:
    format:
        xxx: print a color based on the value of `xxx` placeholder

Requires:
    modemmanager: mobile broadband modem management service
    networkmanager: network connection manager and user applications
    pydbus: pythonic dbus library

Examples:
```
# show state names, eg initializing, searching, registered, connecting.
wwan {
    format = '\?color=state WWAN: {state_name}'
}

# show state names, and when connected, show network information too.
wwan {
    format = 'WWAN:[\?color=state [ {format_ipv4}]'
    format += '[ {format_ipv6}] {state_name}]'
}

# show internet access technologies name with up/down state.
wwan {
    format = 'WWAN: [\?color=state [{access_technologies_name}]'
    format += '[\?soft  ][\?if=state_name=connected up|down]]'
}

# show SMS messages only
wwan {
    format = '[SMS: {format_message}]'
}

# SMS counter
wwan {
    format = 'SMS: {message}/{messages}'
}


# add starter pack thresholds. you do not need to add them all.
wwan {
    thresholds = {
        'access_technologies': [
            (2, 'bad'), (32, 'orange'), (512, 'degraded'), (16384, 'good')
        ],
        'signal_quality_0': [
            (0, 'bad'), (10, 'orange'), (30, 'degraded'), (50, 'good')
        ],
        'signal_quality_1': [
            (False, 'darkgrey'), (True, 'degraded')
        ],
        'state': [
            (-1, 'bad'), (4, 'orange'), (5, 'degraded'), (11, 'good')
        ]
    }
}

# customize WWAN format
wwan {
    format = 'WWAN: [\?color=state {state_name}] '
    format += '[\?if=m3gpp_registration_state_name=HOME {m3gpp_operator_name} ] '
    format += '[\?if=m3gpp_registration_state_name=ROAMING {m3gpp_operator_name} ]'
    format += '[\?color=access_technologies {access_technologies_name} ]'
    format += '[([\?color=signal_quality_0 {signal_quality_0}]]'
    format += '[\?if=!signal_quality_1&color=signal_quality_1 \[!\]|] '
    format += '[\?if=state_name=connected [{format_ipv4}] [{format_stats}]]')
}

# notify users when an event occur... such as new messages, change in state,
# disconnected, etc. you need to specify formatting correctly so it does not
# return anything. otherwise, you always get notifications.
wwan {
    # notify users on low signal percent 25%
    format_notification = '\?if=signal_quality_0<25 Low signal'

    # notify users on connected state
    format_notification = '[\?if=state_name=connected Connected.]'
    format_notification += '[\?if=state_name=disconnected Disconnected.]'

    # message notification
    format_message = '[\?if=index=1 [{number}] [{text}]]'
    format_notification = '[\?if=message>0 {format_message}]'
}
```

@author Cyril Levis (@cyrinux), girst (https://gir.st/)
###############
# wwan_status #
###############
Display network and IP address for newer Huwei modems.

It is tested for Huawei E3276 (usb-id 12d1:1506) aka Telekom Speed
Stick LTE III but may work on other devices too.

Configuration parameters:
    baudrate: There should be no need to configure this, but
        feel free to experiment.
        (default 115200)
    cache_timeout: How often we refresh this module in seconds.
        (default 5)
    consider_3G_degraded: If set to True, only 4G-networks will be
        considered 'good'; 3G connections are shown
        as 'degraded', which is yellow by default. Mostly
        useful if you want to keep track of where there
        is a 4G connection.
        (default False)
    format_down: What to display when the modem is not plugged in
        (default 'WWAN: down')
    format_error: What to display when modem can't be accessed.
        (default 'WWAN: {error}')
    format_no_service: What to display when the modem does not have a
        network connection. This allows to omit the (then
        meaningless) network generation.
        (default 'WWAN: {status} {ip}')
    format_up: What to display upon regular connection
        (default 'WWAN: {status} ({netgen}) {ip}')
    interface: The default interface to obtain the IP address
        from. For wvdial this is most likely ppp0.
        For netctl it can be different.
        (default 'ppp0')
    modem: The device to send commands to. (default '/dev/ttyUSB1')
    modem_timeout: The timespan between querying the modem and
        collecting the response.
        (default 0.4)

Color options:
    color_bad: Error or no connection
    color_degraded: Low generation connection eg 2G
    color_good: Good connection

Requires:
    netifaces: portable module to access network interface information
    pyserial: multiplatform serial port module for python

@author Timo Kohorst timo@kohorst-online.com
PGP: B383 6AE6 6B46 5C45 E594 96AB 89D2 209D DBF3 2BB5

#############
# xkb_input #
#############
Switch inputs.

Configuration parameters:
    button_next: mouse button to cycle next layout (default 4)
    button_prev: mouse button to cycle previous layout (default 5)
    cache_timeout: refresh interval for this module; xkb-switch
        and swaymsg will listen for new updates instead (default 10)
    format: display format for this module (default '{format_input}')
    format_input: display format for inputs
        (default '[{alias}][\?soft  ][\?color=s {s}[ {v}]]')
    format_input_separator: show separator if more than one (default ' ')
    inputs: specify a list of inputs to use in swaymsg (default [])
    switcher: specify xkb-switch, xkblayout-state, xkbgroup,
        or swaymsg to use, otherwise auto (default None)
    thresholds: specify color thresholds to use
        *(default [("fr", "lightgreen"), ("ru", "lightcoral"),
        ("ua", "khaki"),  ("us", "lightskyblue")])*

Format placeholders:
    {format_input} format for inputs
    {input}        number of inputs, eg 1
    {switcher}     eg, xkb-switch, xkblayout-state, xkbgroup, swaymsg

format_input placeholders:
    xkb-switch:
    xkblayout-state:
    xkbgroup:
    swaymsg:
    {c} layout number, eg, 0
    {n} layout name, eg, English (US)
    {s} layout symbol, eg, us
    {v} layout variant, eg, basic
    {e} layout variant, {v} or {s}, eg, dvorak
    {C} layout count, eg, 2
    swaymsg:
    {alias}                   custom string or {name}
    {identifier}              eg, 162:253 USB-HID Keyboard
    {name}                    eg, Trackball, Keyboard, etc
    {vendor}                  eg, 320
    {product}                 eg, 556
    {type}                    eg, pointer, keyboard, touchpad, etc
    {xkb_layout_names}        eg, English (US), French, Russian
    {xkb_active_layout_index} eg, 0, 1, 2, etc
    {xkb_active_layout_name}  eg, English (US)
    {send_events}             eg, True
    {accel_speed}             eg, 0.0
    {accel_profile}           eg, adaptive
    {natural_scroll}          eg, adaptive
    {left_handed}             eg, False
    {middle_emulation}        eg, False
    {scroll_method}           eg, None
    {scroll_button}           eg, 274

        Use `swaymsg -r -t get_inputs` to get a list of current sway inputs
        and for a list of placeholders. Not all of placeholders will be usable.

Color thresholds:
    xxx: print a color based on the value of `xxx` placeholder

Requires:
    xkb-switch: program that allows to query and change the xkb layout state
    xkblayout-state: a command-line program to get/set the current keyboard layout
    xkbgroup: query and change xkb layout state
    swaymsg: send messages to sway window manager

Examples:
```
# sway users: for best results, add switcher to avoid false positives with `pgrep i3`
# because sway users can be using scripts, tools, et cetera with `i3` in its name.
xkb_input {
    switcher = "swaymsg"
}

# sway users: specify inputs to fnmatch
xkb_input {
    # display logitech identifiers
    inputs = [{"identifier": "*Logitech*"}]

    # display logi* keyboards only
    inputs = [{"name": "Logi*", "type": "keyb*"}]

    # display pointers only
    inputs = [{"type": "pointer"}]
}

# sway users: display inputs, optional aliases, et cetera
xkb_input {
    inputs = [
        {"identifier": "1625:3192:Heng_Yu_Technology_Poker_II", "alias": "Poker 2"},
        {"identifier": "0012:021:USB-HID_Keyboard", "alias": "Race 3"},
        {"identifier": "0123:45678:Logitech_MX_Ergo", "alias": "MX Ergo", "type": "pointer"},
    ]
}

# i3 users: display inputs - see https://wiki.archlinux.org/index.php/X_keyboard_extension
# $ setxkbmap -layout "us,fr,ru"  # install xkb-group to enable a listener thread
```

@author lasers, saengowp, javiertury
##########
# xrandr #
##########
Control screen layout.

This modules allows you to handle your screens outputs directly from your bar!
    - Detect and propose every possible screen combinations
    - Switch between combinations using click events and mouse scroll
    - Activate the screen or screen combination on a single click
    - It will detect any newly connected or removed screen automatically

For convenience, this module also proposes some added features:
    - Dynamic parameters for POSITION and WORKSPACES assignment (see below)
    - Automatic fallback to a given screen or screen combination when no more
        screen is available (handy for laptops)
    - Automatically apply this screen combination on start: no need for xorg!
    - Automatically move workspaces to screens when they are available
    - Define your own subset of output combinations to use

Configuration parameters:
    cache_timeout: how often to (re)detect the outputs (default 10)
    command: a custom command to be run after display configuration changes
        (default None)
    fallback: when the current output layout is not available anymore,
        fallback to this layout if available. This is very handy if you
        have a laptop and switched to an external screen for presentation
        and want to automatically fallback to your laptop screen when you
        disconnect the external screen. (default True)
    fixed_width: show output as fixed width (default True)
    force_on_change: switch display layout to the leftmost combination mode
        of the given list whenever it is available. The combination modes are
        checked from left (high priority) to right (less priority) until
        one matches.
        Example:
        We have a laptop with internal screen and we are often moving from
        our desk where another screen is available. We want the layout to
        follow our changes so that we do not have to switch manually.
        So whenever we plug at our desk, we want the second monitor to be
        used, and whenever we go away we want everything back on the laptop
        screen automatically:
            ```
            force_on_change = ["eDP1+DP1", "eDP1"]
            ```
        NOTES:
        Click controls will override `force_on_change` until the layout
        changes in the background so you can still manually control your
        layout changes on the bar.
        Use the `force_on_start` to handle initial layout setup on module
        startup along with this feature to benefit from fully dynamic and
        automated changes of screen layouts.
        (default [])
    force_on_start: switch to the given combination mode if available
        when the module starts (saves you from having to configure xorg)
        (default None)
    format: display format for xrandr
        (default '{output}')
    hide_if_single_combination: hide if only one combination is available
        (default False)
    icon_clone: icon used to display a 'clone' combination
        (default '=')
    icon_extend: icon used to display a 'extend' combination
        (default '+')
    on_udev_drm: dynamic variable to watch for `drm` udev subsystem events to
        trigger specified action.
        (default 'refresh_and_freeze')
    output_combinations: string used to define your own subset of output
        combinations to use, instead of generating every possible combination
        automatically. Provide the values in the format that this module uses,
        splitting the combinations using '|' character.
        The combinations will be rotated in the exact order as you listed them.
        When an output layout is not available any more, the configurations
        are automatically filtered out.
        Example:
        Assuming the default values for `icon_clone` and `icon_extend`
        are used, and assuming you have two screens 'eDP1' and 'DP1', the
        following setup will reduce the number of output combinations
        from four (every possible one) down to two.
            ```
            output_combinations = "eDP1|eDP1+DP1"
            ```
        (default None)

Dynamic configuration parameters:
    - `<OUTPUT>_icon` use this icon instead of OUTPUT name as text
        Example: DP1_icon = "🖵"
    - `<OUTPUT>_pos` apply the given position to the OUTPUT
        Example: DP1_pos = "-2560x0"
        Example: DP1_pos = "above eDP1"
        Example: DP1_pos = "below eDP1"
        Example: DP1_pos = "left-of LVDS1"
        Example: DP1_pos = "right-of eDP1"
    - `<OUTPUT>_workspaces` comma separated list of workspaces to move to
        the given OUTPUT when it is activated
        Example: DP1_workspaces = "1,2,3"
    - `<OUTPUT>_rotate` rotate the output as told
        Example: DP1_rotate = "left"
    - `<OUTPUT>_mode` define the mode (resolution) for the output
        if not specified use --auto : preferred mode
        Example: eDP1_mode = "2560x1440
    - `<OUTPUT>_primary` apply the primary to the OUTPUT
        Example: DP1_primary = True

Format placeholders:
    {output} xrandr output

Color options:
    color_bad: Displayed layout unavailable
    color_degraded: Using a fallback layout
    color_good: Displayed layout active

Notes:
        Some days are just bad days. Running `xrandr --query` command can
        cause unexplainable brief screen freezes due to an overall combination
        of computer hardware, installed software, your choice of linux distribution,
        and/or some other unknown factors such as recent system updates.

    Configuring `cache_timeout` with a different number, eg `3600` (an hour)
    or `-1` (runs once) can be used to remedy this issue. See issue #580.

Examples:
```
# start with a preferable setup
xrandr {
    force_on_start = "eDP1+DP1"
    DP1_pos = "left-of eDP1"
    VGA_workspaces = "7"
}
```

@author ultrabug
#################
# xrandr_rotate #
#################
Control screen rotation.

Configuration parameters:
    cache_timeout: how often to refresh this module.
        (default 10)
    format: a string that formats the output, can include placeholders.
        (default '{icon}')
    hide_if_disconnected: a boolean flag to hide icon when `screen` is
        disconnected.
        It has no effect unless `screen` option is also configured.
        (default False)
    horizontal_icon: a character to represent horizontal rotation.
        (default 'H')
    horizontal_rotation: a horizontal rotation for xrandr to use.
        Available options: 'normal' or 'inverted'.
        (default 'normal')
    screen: display output name to rotate, as detected by xrandr.
        If not provided, all enabled screens will be rotated.
        (default None)
    vertical_icon: a character to represent vertical rotation.
        (default 'V')
    vertical_rotation: a vertical rotation for xrandr to use.
        Available options: 'left' or 'right'.
        (default 'left')

Format placeholders:
    {icon} a rotation icon, specified by `horizontal_icon` or `vertical_icon`.
    {screen} a screen name, specified by `screen` option or detected
        automatically if only one screen is connected, otherwise 'ALL'.

Color options:
    color_degraded: Screen is disconnected
    color_good: Displayed rotation is active

@author Maxim Baz (https://github.com/maximbaz)
@license BSD
################
# xscreensaver #
################
Control Xscreensaver.

This script is useful for people who let Xscreensaver manage DPMS settings.
Xscreensaver has its own DPMS variables separate from xset. DPMS can be
safely turned off in xset as long as Xscreensaver is running.
Settings can be managed using "xscreensaver-demo".

Configuration parameters:
    button_activate: mouse button to activate Xscreensaver (default 3)
    button_toggle: mouse button to toggle Xscreensaver (default 1)
    cache_timeout: refresh interval for this module (default 15)
    format: display format for this module (default '{icon}')
    icon_off: show when Xscreensaver is not running (default 'XSCR')
    icon_on: show when Xscreensaver is running (default 'XSCR')

Format placeholders:
    {icon} Xscreensaver icon

Color options:
    color_on: Enabled, defaults to color_good
    color_off: Disabled, defaults to color_bad

@author neutronst4r, lasers
########
# xsel #
########
Display X selection.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 0.5)
    command: the clipboard command to run (default 'xsel --output')
    format: display format for this module (default '{selection}')
    log_file: specify the clipboard log to use (default None)
    max_size: strip the selection to this value (default 15)
    symmetric: show beginning and end of the selection string
        with respect to configured max_size. (default True)

Format placeholders:
    {selection} output from clipboard command

Requires:
    xsel: a command-line program to retrieve/set the X selection

Examples:
```
xsel {
    max_size = 50
    command = "xsel --clipboard --output"
    on_click 1 = "exec xsel --clear --clipboard"
    log_file = "~/.local/share/xsel/clipboard_log"
}
```

@author Sublim3 umbsublime@gamil.com
@license BSD
#####################
# yandexdisk_status #
#####################
Display Yandex.Disk status.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for this module (default 'Yandex.Disk: {status}')
    status_busy: show when Yandex.Disk is busy (default None)
    status_off: show when Yandex.Disk isn't running (default 'Not started')
    status_on: show when Yandex.Disk is idling (default 'Idle')

Format placeholders:
    {status} Yandex.Disk status

Color options:
    color_bad: Not started
    color_degraded: Idle
    color_good: Busy

Requires:
    yandex-disk: command line interface for Yandex.Disk

@author Vladimir Potapev (github:vpotapev)
@license BSD
###########
# yubikey #
###########
Show an indicator when YubiKey is waiting for a touch.

Configuration parameters:
    format: Display format for the module.
        (default '[YubiKey[\?if=is_gpg ][\?if=is_u2f ]]')
    socket_path: A path to the yubikey-touch-detector socket file.
        (default '$XDG_RUNTIME_DIR/yubikey-touch-detector.socket')

Control placeholders:
    {is_gpg} a boolean, True if YubiKey is waiting for a touch due to a gpg operation.
    {is_u2f} a boolean, True if YubiKey is waiting for a touch due to a pam-u2f request.

Requires:
    github.com/maximbaz/yubikey-touch-detector: tool to detect when YubiKey is waiting for a touch

@author Maxim Baz (https://github.com/maximbaz)
@license BSD
