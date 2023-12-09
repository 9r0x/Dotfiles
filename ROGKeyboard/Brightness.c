#include <stdio.h>
#include <stdlib.h>
#include <libusb-1.0/libusb.h>

#define VENDOR_ID 0x0b05
#define PRODUCT_ID 0x1a30

#define BM_REQUEST_TYPE 0x21 // Host to device, Class, Interface
#define B_REQUEST 0x09       // SET_REPORT
#define W_VALUE 0x035a       // Report Type and ID
#define W_INDEX 0            // Interface
#define W_LENGTH 64          // Length of the data

int main(int argc, char *argv[])
{
    libusb_device_handle *handle = NULL;
    int err = 0;
    int brightness = 0;
    unsigned char payload[W_LENGTH] = {0};

    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <brightness 0-3>\n", argv[0]);
        return -1;
    }

    brightness = atoi(argv[1]) & 0xff;
    if (brightness < 0 || brightness > 3)
    {
        fprintf(stderr, "Invalid brightness value\n");
        return -1;
    }

    payload[0] = 0x5a;
    payload[1] = 0xba;
    payload[2] = 0xc5;
    payload[3] = 0xc4;
    payload[4] = (unsigned char)brightness;

    // Initialize the library
    err = libusb_init(NULL);
    if (err)
    {
        fprintf(stderr, "Failed to initialize libusb: %s\n", libusb_error_name(err));
        return -1;
    }

    // Open the device
    handle = libusb_open_device_with_vid_pid(NULL, VENDOR_ID, PRODUCT_ID);
    if (!handle)
    {
        fprintf(stderr, "Failed to open device\n");
        libusb_exit(NULL);
        return -1;
    }

    // Detach the kernel driver if necessary
    if (libusb_kernel_driver_active(handle, 0) == 1)
    {
        err = libusb_detach_kernel_driver(handle, 0);
        if (err)
        {
            fprintf(stderr, "Failed to detach kernel driver: %s\n", libusb_error_name(err));
            libusb_close(handle);
            libusb_exit(NULL);
            return -1;
        }
    }

    // Change the brightness
    err = libusb_control_transfer(handle,
                                  BM_REQUEST_TYPE,
                                  B_REQUEST,
                                  W_VALUE,
                                  W_INDEX,
                                  payload,
                                  W_LENGTH,
                                  1000); // Timeout in milliseconds

    if (err < 0)
        fprintf(stderr, "Error sending control transfer: %s\n", libusb_error_name(err));
    else
        fprintf(stdout, "Brightness changed to %d\n", brightness);

    // Close the device
    libusb_close(handle);

    // Deinitialize the library
    libusb_exit(NULL);

    return 0;
}
