import struct, codecs

# Read raw file
with open('E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_20260428_143259.sqlite', 'rb') as f:
    raw = f.read()

print("File size:", len(raw))
print("Raw header:", raw[:32].hex())

# Check if it's actually a text file
if raw[:2] == b'\xff\xfe':
    print("Has UTF-16LE BOM")
    # Try complete decode
    text = raw[2:].decode('utf-16le')
    print("Decoded text length:", len(text))
    # print("First 200 chars (repr):", repr(text[:200]))
    
    # Now convert properly - back to bytes
    # Each character in the decoded text is actually a byte value
    byte_data = bytearray()
    for ch in text:
        byte_data.append(ord(ch) & 0xFF)
    
    print("Re-encoded size:", len(byte_data))
    print("Header:", byte_data[:16].hex())
    print("Expected: 53514c69746520666f726d6174203300")
    
    with open('E:/db_fixed.sqlite', 'wb') as f:
        f.write(byte_data)
    print("Wrote to E:/db_fixed.sqlite")

print("\nDone")
