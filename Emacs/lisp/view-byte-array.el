(defun view-byte-array (format)
  "View the current file in od dump"
  (interactive "sFormat Code: ")
  (let* (
	 ($outputbuffer "*od dump*")
         ($fname (buffer-file-name))
         $cmdStr)
    (setq $cmdStr (concat "od --endian=big -t " format " \""   $fname "\" &"))
    (message "Running %s" $cmdStr)
    (shell-command $cmdStr $outputbuffer)
    )
  )

(provide 'view-byte-array)
;;; view-byte-array.el ends here
