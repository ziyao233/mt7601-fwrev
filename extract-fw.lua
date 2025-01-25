#!/usr/bin/env lua5.4
-- SPDX-License-Identifier: MPL-2.0
--[[
--	extract-fw.lua
--	Print header information and strip it
--	Copyright (c) 2024 Yao Zi.
--]]

--[[
	struct mt76_fw_header {
	        __le32 ilm_len;
	        __le32 dlm_len;
	        __le16 build_ver;
	        __le16 fw_ver;
	        u8 pad[4];
	        char build_time[16];
	};
--]]

local function
pf(...)
	io.stdout:write(string.format(...));
end

local file = assert(io.open(assert(arg[1]))):read('a');

-- We have a 32bytes header
local ilmLen, dlmLen, buildVer, fwVer, buildTime =
	string.unpack("<I4I4I2I2xxxxc16", file);
assert(ilmLen and dlmLen and buildVer and fwVer and buildTime);
pf("ilmlen: 0x%x (%d), dlmLen: 0x%x (%d)\n", ilmLen, ilmLen, dlmLen, dlmLen);
pf("build version %d (0x%x), firmware version %d\n", buildVer, buildVer, fwVer);
pf("build time string: %s\n", buildTime:gsub('_', ''));
file = file:sub(33, -1);

local ivb = file:sub(1, 0x40);
local ilm = file:sub(0x41, 0x40 + ilmLen);
assert(io.open("ivb.bin", 'w')):write(ivb);
assert(io.open("ilm.bin", 'w')):write(ilm);
