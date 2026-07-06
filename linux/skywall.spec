# -*- mode: python ; coding: utf-8 -*-
import os, sys

block_cipher = None
root_dir = os.path.abspath(os.path.join(os.getcwd(), '..'))

a = Analysis(
    [os.path.join(root_dir, 'skywall.py')],
    pathex=[root_dir],
    binaries=[],
    datas=[(os.path.join(root_dir, 'static'), 'static')],
    hiddenimports=['flask', 'requests', 'cryptography', 'atexit'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='Skywall',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='Skywall',
)
