
import sys

def recover(input_path, output_path):
    try:
        with open(input_path, 'rb') as f:
            content = f.read()
        
        # Check if it's UTF-16LE with BOM
        if content[:2] == b'\xff\xfe':
            print(f"Detected UTF-16LE BOM in {input_path}")
            # Try to decode as UTF-16LE and encode as Latin-1 (which is 1-to-1 for 0-255)
            recovered = content[2:].decode('utf-16-le').encode('latin-1')
            with open(output_path, 'wb') as f:
                f.write(recovered)
            print(f"Successfully recovered to {output_path}")
            return True
        else:
            print(f"No UTF-16LE BOM detected in {input_path}")
            return False
    except Exception as e:
        print(f"Error recovering {input_path}: {e}")
        return False

if __name__ == "__main__":
    recover('build/backups/gym_log_20260504_141714.sqlite', 'recovered_test.sqlite')
