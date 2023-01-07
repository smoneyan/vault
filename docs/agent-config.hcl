exit_after_auth = false
pid_file = "./pidfile"

auto_auth {
   method "approle" {
       mount_path = "auth/approle"
       config = {
           role_id_file_path = "/tmp/role-id"
           secret_id_file_path = "/tmp/secret-id"
           remove_secret_id_file_after_reading = false
       }
   }

   sink "file" {
       config = {
           path = "/tmp/token"
       }
   }
}

vault {
   address = "http://127.0.0.1:8200"
}
