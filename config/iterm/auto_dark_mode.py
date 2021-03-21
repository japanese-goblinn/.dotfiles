#!/usr/bin/env python3.7

import asyncio
import iterm2


async def update(connection, theme):
    parts = theme.split(" ")
    if "dark" in parts:
        preset = await iterm2.ColorPreset.async_get(connection, "Raycast_Dark")
    else:
        preset = await iterm2.ColorPreset.async_get(connection, "Raycast_Light")
    profiles = await iterm2.PartialProfile.async_query(connection)
    for partial in profiles:
        profile = await partial.async_get_full_profile()
        await profile.async_set_color_preset(preset)


async def main(connection):
    app = await iterm2.async_get_app(connection)
    await update(connection, await app.async_get_variable("effectiveTheme"))
    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            theme = await mon.async_get()
            await update(connection, theme)


iterm2.run_forever(main)
