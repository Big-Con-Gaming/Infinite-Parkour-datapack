from mcrcon import MCRcon

if __name__ == "__main__":
    raise RuntimeError("This module is not meant to be run directly. Please use the setup function to configure the RCON connection.")



def setup(_HOST, _PASSWORD, _PORT, _prefix=""):
    global HOST, PASSWORD, PORT, PREFIX
    HOST = _HOST
    PASSWORD = _PASSWORD
    PORT = _PORT
    PREFIX = _prefix
    global mcr
    with MCRcon(HOST, PASSWORD, port=PORT) as mcr:
     mcr.command(PREFIX+"RCON connection established successfully.")
    print(f"Setup complete. You can now use the MCRcon instance with the provided credentials: {HOST}, {PORT} and {PASSWORD}.")
    return True

def c(command):
    with MCRcon(HOST, PASSWORD, port=PORT) as mcr:
     response = mcr.command(PREFIX+command)
    return response

def run_file(filename):
    with open(filename, "r") as file:
        commands = file.readlines()
    for command in commands:
        command = command.strip()
        if command:  # Skip empty lines
            c(command)
    return True