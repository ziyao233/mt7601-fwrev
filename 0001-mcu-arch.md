# 0001: Basic Architecture of the Microcontroller

The firmware is actually an executable which driver uploads into the
microcontroller integrated in MT7601u.

The MCU is based on AndeStar architecture (or NDS32),

- V3m version
- ILM starts at `0x0`.
- Currently no firmware comes with a non-empty DLM.
- 16 interrupts, 4 bytes for each interrupt entry. IVB locates at the start of
  ILM.
  TODO: check whether other interrupt entry size/IVB address is supported.
- Reduced Address Space enabled (address space is limited to 24-bit)
  (NEED CONFIRMATION)

## Reference

- [Documentation Page of Andes Technology](https://www.andestech.com/en/products-solutions/product-documentation/)
