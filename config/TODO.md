# To-Do

- [ ] Auto install and setup [z](https://github.com/rupa/z)
- [ ] Fix annoying inotify instance limit errors in Fedora by editing the `/proc/sys/fs/inotify/max_user_instances` file,
      or using this command

  ```sh
  sudo sysctl fs.inotify.max_user_instances=256
  ```
