import xml.etree.ElementTree as ET

def get_text(parent, tag):
    if parent is None:
        return ""
    child = parent.find(tag)
    return child.text.strip() if child is not None and child.text else ""

tree = ET.parse("people.xml")      
root = tree.getroot()

with open("output.dat", "w", encoding="utf-8") as out:

    # Iterate through every person
    for person in root.findall("person"):

        # -------- 200 Record --------
        name = person.find("name")
        first = get_text(name, "firstName")
        last = get_text(name, "lastName")

        out.write(f"200|{first}|{last}\n")

        # -------- 300 Record --------
        contact = person.find("contact")
        email = get_text(contact, "email")
        phone = get_text(contact, "phone")

        out.write(f"300|{email}|{phone}\n")

        # -------- 400 Record --------
        address = person.find("address")
        street = get_text(address, "street")
        city = get_text(address, "city")
        state = get_text(address, "state")
        postal = get_text(address, "postalCode")
        country = get_text(address, "country")

        out.write(
            f"400|{street}|{city}|{state}|{postal}|{country}\n"
        )

        # -------- 500 Record --------
        employment = person.find("employment")
        company = get_text(employment, "company")
        title = get_text(employment, "title")
        start = get_text(employment, "startDate")

        out.write(f"500|{company}|{title}|{start}\n")

        # Blank line between people (optional)
        out.write("\n")

print("output.dat created successfully.")