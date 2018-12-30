#ifdef IMAC_10_1_PM
    External (CFGD)
    External (_PSS)
    External (PDC0)
    External (PDC1)
    External (\_PR_.CPU0, DeviceObj)
    External (\_PR_.CPU0._TSS, IntObj)
    External (\_PR_.CPU0._PTC, IntObj)
    External (\_PR_.CPU1, DeviceObj)
    
    Scope (\_PR.CPU0)
    {
        Name (TCNT, 0x02)                       // CPU threads count
        Name (_TPC, 0x00)
        Method (_PTC, 0, NotSerialized)
        {
            If (And (PDC0, 0x04))
            {
                Return (Package (0x02)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }, 

                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }
                })
            }

            Return (Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 
                        0x05,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000410, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemIO, 
                        0x05,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000410, // Address
                        ,)
                }
            })
        }

        Name (TSMF, Package (0x0F)
        {
            Package (0x05)
            {
                0x64, 
                0x03E8, 
                0x00, 
                0x00, 
                0x00
            }, 

            Package (0x05)
            {
                0x5E, 
                0x03AC, 
                0x00, 
                0x1F, 
                0x00
            }, 

            Package (0x05)
            {
                0x58, 
                0x0370, 
                0x00, 
                0x1E, 
                0x00
            }, 

            Package (0x05)
            {
                0x52, 
                0x0334, 
                0x00, 
                0x1D, 
                0x00
            }, 

            Package (0x05)
            {
                0x4B, 
                0x02F8, 
                0x00, 
                0x1C, 
                0x00
            }, 

            Package (0x05)
            {
                0x45, 
                0x02BC, 
                0x00, 
                0x1B, 
                0x00
            }, 

            Package (0x05)
            {
                0x3F, 
                0x0280, 
                0x00, 
                0x1A, 
                0x00
            }, 

            Package (0x05)
            {
                0x39, 
                0x0244, 
                0x00, 
                0x19, 
                0x00
            }, 

            Package (0x05)
            {
                0x32, 
                0x0208, 
                0x00, 
                0x18, 
                0x00
            }, 

            Package (0x05)
            {
                0x2C, 
                0x01CC, 
                0x00, 
                0x17, 
                0x00
            }, 

            Package (0x05)
            {
                0x26, 
                0x0190, 
                0x00, 
                0x16, 
                0x00
            }, 

            Package (0x05)
            {
                0x20, 
                0x0154, 
                0x00, 
                0x15, 
                0x00
            }, 

            Package (0x05)
            {
                0x19, 
                0x0118, 
                0x00, 
                0x14, 
                0x00
            }, 

            Package (0x05)
            {
                0x13, 
                0xDC, 
                0x00, 
                0x13, 
                0x00
            }, 

            Package (0x05)
            {
                0x0D, 
                0xA0, 
                0x00, 
                0x12, 
                0x00
            }
        })
        Name (TSMC, Package (0x08)
        {
            Package (0x05)
            {
                0x64, 
                0x03E8, 
                0x00, 
                0x00, 
                0x00
            }, 

            Package (0x05)
            {
                0x58, 
                0x036B, 
                0x00, 
                0x1E, 
                0x00
            }, 

            Package (0x05)
            {
                0x4B, 
                0x02EE, 
                0x00, 
                0x1C, 
                0x00
            }, 

            Package (0x05)
            {
                0x3F, 
                0x0271, 
                0x00, 
                0x1A, 
                0x00
            }, 

            Package (0x05)
            {
                0x32, 
                0x01F4, 
                0x00, 
                0x18, 
                0x00
            }, 

            Package (0x05)
            {
                0x26, 
                0x0177, 
                0x00, 
                0x16, 
                0x00
            }, 

            Package (0x05)
            {
                0x19, 
                0xFA, 
                0x00, 
                0x14, 
                0x00
            }, 

            Package (0x05)
            {
                0x0D, 
                0x7D, 
                0x00, 
                0x12, 
                0x00
            }
        })
        Name (TSSF, 0x00)
        Mutex (TSMO, 0x00)
        Method (_TSS, 0, NotSerialized)
        {
            If (LAnd (LNot (TSSF), CondRefOf (_PSS)))
            {
                Acquire (TSMO, 0xFFFF)
                If (LAnd (LNot (TSSF), CondRefOf (_PSS)))
                {
                    Name (LFMI, 0x00)
                    Store (SizeOf (_PSS), LFMI)
                    Decrement (LFMI)
                    Name (LFMP, 0x00)
                    Store (DerefOf (Index (DerefOf (Index (_PSS, LFMI)), 0x01)), 
                        LFMP)
                    Store (0x00, Local0)
                    If (And (CFGD, 0x00080000))
                    {
                        Store (RefOf (TSMF), Local1)
                        Store (SizeOf (TSMF), Local2)
                    }
                    Else
                    {
                        Store (RefOf (TSMC), Local1)
                        Store (SizeOf (TSMC), Local2)
                    }

                    While (LLess (Local0, Local2))
                    {
                        Store (Divide (Multiply (LFMP, Subtract (Local2, Local0)), Local2, 
                            ), Local4)
                        Store (Local4, Index (DerefOf (Index (DerefOf (Local1), Local0)), 0x01
                            ))
                        Increment (Local0)
                    }

                    Store (Ones, TSSF)
                }

                Release (TSMO)
            }

            If (And (CFGD, 0x00080000))
            {
                Return (TSMF)
            }
            Else
            {
                Return (TSMC)
            }
        }

        Method (_TSD, 0, NotSerialized)
        {
            If (LNot (And (PDC0, 0x04)))
            {
                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        0x00, 
                        0x00, 
                        0xFD, 
                        TCNT
                    }
                })
            }

            Return (Package (0x01)
            {
                Package (0x05)
                {
                    0x05, 
                    0x00, 
                    0x00, 
                    0xFC, 
                    TCNT
                }
            })
        }
    }

    Scope (\_PR.CPU1)
    {
        Name (_TPC, 0x00)
        Method (_PTC, 0, NotSerialized)
        {
            Return (\_PR.CPU0._PTC)
        }

        Method (_TSS, 0, NotSerialized)
        {
            Return (\_PR.CPU0._TSS)
        }

        Method (_TSD, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0x01000000), LNot (And (PDC1, 0x04
                ))))
            {
                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        0x00, 
                        0x00, 
                        0xFD, 
                        0x02
                    }
                })
            }

            Return (Package (0x01)
            {
                Package (0x05)
                {
                    0x05, 
                    0x00, 
                    0x01, 
                    0xFC, 
                    0x01
                }
            })
        }
    }
#endif