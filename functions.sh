# Functions supporting shell cx.sh script                                                              
 
func_create_ssh_dir () {
  if [[ ! -d $SSH_DIR ]]; then
    echo "Creating SSH Directory"
    mkdir $SSH_DIR
  else
    echo "$SSH_DIR already exists"
  fi
 
  if [[ ! -d $SSH_DIR/keys ]]; then
    echo "Creating SSH Directory"
    mkdir $SSH_DIR/keys
  else
    echo "$SSH_DIR/keys already exists"
  fi
 
 
 
 
  return
}
