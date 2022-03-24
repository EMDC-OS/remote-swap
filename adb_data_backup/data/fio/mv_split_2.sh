split -b 512M /data/swapfile ./fio_test_file.
mv fio_test_file.aa fio_test_file.0.0
mv fio_test_file.ab fio_test_file.1.0
