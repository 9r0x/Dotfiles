(defun view-byte-array (endian format)
  "View the current file in od dump"
  (interactive "sEndian: \nsFormat Code: ")
  (let* (
	 ($outputbuffer "*od dump*")
         ($fname (buffer-file-name))
         $cmdStr)
    (setq $cmdStr (concat "od --endian=" endian " -t " format " \""   $fname "\" &"))
    (message "Running %s" $cmdStr)
    (shell-command $cmdStr $outputbuffer)
    )
  )

(provide 'view-byte-array)
;;; view-byte-array.el ends here
