#
# (C) Copyright 2005
# Cavium Networks
#
# See file CREDITS for list of people who contributed to this
# project.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#

#
# Kodama board with OCTEON 3630
#

# Valid TEXT_BASE values:
#  0xbfc00000  failsafe bootloader
#  0xbfc40000  regular bootloader (jumped to from failsafe bootloader when GPIO0 low)
#  0x80100000  ram-based bootloader

# config.tmp created by top-level configuration
sinclude $(TOPDIR)/board/$(BOARDDIR)/config.tmp
