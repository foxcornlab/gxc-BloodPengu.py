<p align="center">
    <picture>
        <img src="./src/img/craken_husk.png" alt="BloodPengu.py" width='300'/>
    </picture>
</p>

<p align="center">
  <a href="https://github.com/foxcornlab/gxc-BloodPengu.py/releases">1.5.8</a> •
  <a href="#">SuSHi Rav3n</a>
</p>

<hr/>

# `gxc-BloodPengu.py`

![Python 3 compatible](https://img.shields.io/badge/python-3.X-blue.svg)
![License: Apache-2.0](https://img.shields.io/badge/license-Apache_License_2.0-blue)

Data ingestor in `Python` for `BloodPengu` APM, f.k.a. Attack Path Manager.

It logs on over `SSH`, runs the full enumeration pipeline on the target, and drops everything on your own machine as one `JSON` file (`-o` output, default `pypengu-output.json`). Import that file straight into `BloodPengu` and the attack paths draw themselves.

No payloads. No exploitation. It only reads what the account you logged in with can already see.

## `Features`

What it collects over `SSH`, by default, all of it:

- `users` - local users, `UID 0` accounts, shells, homes
- `sudo` - `NOPASSWD` rules, dangerous sudo binaries, misconfigs
- `suid` - `SUID`/`SGID` binaries, cross-referenced against `GTFOBins`
- `groups` - privileged groups: `docker`, `lxd`, `disk`, `shadow`, `adm`
- `services` - writable `systemd` units, hijackable service scripts
- `cron` - writable cron scripts, scheduled-task privilege paths
- `kernel` - kernel version matched against a known `CVE` list
- `containers` - `Docker` socket, in-container detection, `AWS`/`GCP`/`K8s` creds
- `network` - listening ports, interfaces, internal ranges
- `env` - env vars, history files, interesting files in home and `opt`

## `Modules`

Extra collectors, run one or several with `-M` (comma separated):

- `sacspengu` - compiler and binary analysis suggestor
- `avrisk` - anti-virus discovery
- `brace` - container and cloud assessor
- `mi6` - stealth surface assessment: history controls, syslog exposure, `argv` masking, auditd, `SIEM` agents
- `kernel` - full kernel and `LPE` checklist: `CVE` matches, capabilities, writable timers, `D-Bus` policies, `SUID` interpreters

For the full module notes, read [`src/modules/README.md`](src/modules/README.md).

```bash
bloodpengu-python 10.10.10.10 -u kraken -p 'kr@ken' -M kernel,mi6
bloodpengu-python 10.10.10.10 -u kraken -k ~/.ssh/id_rsa -o ./results/kraken.json -v
```

## `Install`

Full steps live on the [`Install`](Install.md) page. Short version:

```bash
pipx install bloodpengu-python
```

Or from source:

```bash
git clone https://github.com/foxcornlab/gxc-BloodPengu.py.git
cd gxc-BloodPengu.py
pip install . --break-system-packages
```

Needs `Python 3.7+` and `paramiko>=3.0.0`. A `Dockerfile` is included if you would rather run it containerised (`bloodpengu-python` is the entrypoint).

## `Usage`

```bash
bloodpengu-python <target> -u <username> -p <password>
bloodpengu-python <target> -u <username> -k <keyfile>
bloodpengu-python <target> -u <username> -k <keyfile> --port 2222
bloodpengu-python <target> -u <username> -p <password> -d kraken.htb -v
bloodpengu-python <target> -u <username> -p <password> -M sacspengu
bloodpengu-python <target> -u <username> -p <password> --old-ssh
bloodpengu-python <target> -u <username> -p <password> --jumphost user:pass@jump:22
```

Run `bloodpengu-python -h` for the full option list, module list, and collector table. A synthetic sample import lives in [`.data/`](.data/) (`bloodpengu_out.json`, `pengu_out.json`) so you can see the output shape before you ever point it at a host.

## `Notes`

- The `kernel` collector matches the target kernel against a built-in `CVE` list. A match means "check this", not "this is exploitable here". Verify before you claim anything.
- `mi6` assesses stealth surfaces, it does not hide your session. If you need quiet, that is your tradecraft, not this tool.
- Output is yours. It lands on the machine you ran the tool from, never on the target.

## `Thanks to`

- The `BloodPengu` APM project ([pengu-apm.github.io](https://pengu-apm.github.io/)) for the graph this feeds into
- `Pennyw0rth` and the `BloodPengu` contributors
- `GTFOBins` for the `SUID` cross-reference data

## `Disclaimer`

Built for authorised security testing, lab work, and learning. Only run it against systems you own or have explicit permission to test. The author is not responsible for misuse.

## `LICENSE`

`Apache-2.0`. See [`LICENSE`](LICENSE).

> Research by `Vineeth Kumar` (`foxcornlab`). Found a bug or want a feature, open an `issue`.
