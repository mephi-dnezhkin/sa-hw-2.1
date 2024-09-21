Name:           check-hosts
Version:        1.0
Release:        1%{?dist}
Summary:        A simple script to check the availability of hosts

License:        GPLv3+
Source0:        check-hosts

BuildArch:      x86_64

%description
check-hosts is a simple shell script to check the availability of hosts on the network using ping.

%prep

%build

%install
mkdir -p %{buildroot}/usr/bin
install -m 755 %{_sourcedir}/check-hosts %{buildroot}/usr/bin/check-hosts

%files
/usr/bin/check-hosts

%changelog
* Wed Sep 18 2024 Dmitriy Nezhkin <nezhkind@mail.ru> - 1.0-1
- Initial release of check-hosts
