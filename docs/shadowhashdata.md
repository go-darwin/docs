# password cracking use ShadowHashData

https://apple.stackexchange.com/questions/220729/what-type-of-hash-are-a-macs-password-stored-in

## Password cracking (valid in OS 10.8 and newer)

First I want to explain your command:

```console
sudo defaults read /var/db/dslocal/nodes/Default/users/user.plist ShadowHashData|tr -dc 0-9a-f|xxd -r -p|plutil -convert xml1 - -o -
```

---

The first part of the command reads the key ShadowHashData in the plist

```console
sudo defaults read /var/db/dslocal/nodes/Default/users/user.plist ShadowHashData
```

Result (mostly hex):

```
(
    <62706c69 73743030 d101025f 10145341 4c544544 2d534841 3531322d 50424b44 4632d303 04050607 0857656e 74726f70 79547361 6c745a69 74657261 74696f6e 734f1080 c5f19863 9915a101 c99af326 dffe13e8 f14456be 8fd2312a 39a777b9 2178804e 204ca4fe e12a8667 871440ef f4288e81 1d86d746 c6d96a60 c919c341 8dfebba4 2f329f5d 73c0372d 636d61d5 dfda1add 61af36c7 0e4acd77 12761072 09e643ae 92a0f43e 95a45274 4e50fb45 40d9bdf4 e0b70172 5d7db488 fbe18c1a b7737c6b 4f10200d ba6246bd 38266b2e 827ff7e7 27138075 7c71d653 893aa361 d5902398 30236911 c160080b 22293136 41c4e700 00000000 00010100 00000000 00000900 00000000 00000000 00000000 0000ea>
)
```

the second part of the command tr -dc 0-9a-f removes anything except 0-9a-f.

Result (hex):

```
62706c6973743030d101025f101453414c5445442d5348413531322d50424b444632d303040506070857656e74726f70795473616c745a697465726174696f6e734f1080c5f198639915a101c99af326dffe13e8f14456be8fd2312a39a777b92178804e204ca4fee12a8667871440eff4288e811d86d746c6d96a60c919c3418dfebba42f329f5d73c0372d636d61d5dfda1add61af36c70e4acd771276107209e643ae92a0f43e95a452744e50fb4540d9bdf4e0b701725d7db488fbe18c1ab7737c6b4f10200dba6246bd38266b2e827ff7e7271380757c71d653893aa361d590239830236911c160080b2229313641c4e700000000000001010000000000000009000000000000000000000000000000ea
```

the third part xxd -r -p reverts it to a (mal-formed) binary:

```
?bF?8&k.???'?u|q?S?:?aՐ#?0#i?`WentropyTsaltZiterationsO???c??ɚ?&????DV???1*9?w?!x?N L???*?g?@??(????F??j`??A????/2?]s?7-cma????a?6?J?wvr    ?C????>??RtNP?E@ٽ??r]}?????s|kO                              ")16A??    ?
```

and the last part plutil -convert xml1 - -o - creates a well-formed xml plist:

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>SALTED-SHA512-PBKDF2</key>
    <dict>
        <key>entropy</key>
        <data>
        xfGYY5kVoQHJmvMm3/4T6PFEVr6P0jEqOad3uSF4gE4gTKT+4SqGZ4cUQO/0
        KI6BHYbXRsbZamDJGcNBjf67pC8yn11zwDctY21h1d/aGt1hrzbHDkrNdxJ2
        EHIJ5kOukqD0PpWkUnROUPtFQNm99OC3AXJdfbSI++GMGrdzfGs=
        </data>
        <key>iterations</key>
        <integer>49504</integer>
        <key>salt</key>
        <data>
        DbpiRr04Jmsugn/35ycTgHV8cdZTiTqjYdWQI5gwI2k=
        </data>
    </dict>
</dict>
</plist>
```

To get a real file replace -o - by -o tempuser.plist

The plist contains three key parts: iterations, entropy and salt.

iterations is just an integer, but entropy and salt are base64 encoded. To continue working with them you have to decode and xxd them:

To decode salt remove all spaces and new lines from the data part and use

```console
echo "salt_data" | base64 -D | xxd -p | tr -d \\n > salt
```

With my data above that's

```console
$ echo "DbpiRr04Jmsugn/35ycTgHV8cdZTiTqjYdWQI5gwI2k=" | base64 -D | xxd -p | tr -d \\n > salt
```

with the salt(hex) result:

```
0dba6246bd38266b2e827ff7e7271380757c71d653893aa361d5902398302369
```

The same for entropy:

```console
echo "xfGYY5kVoQHJmvMm3/4T6PFEVr6P0jEqOad3uSF4gE4gTKT+4SqGZ4cUQO/0KI6BHYbXRsbZamDJGcNBjf67pC8yn11zwDctY21h1d/aGt1hrzbHDkrNdxJ2EHIJ5kOukqD0PpWkUnROUPtFQNm99OC3AXJdfbSI++GMGrdzfGs=" | base64 -D | xxd -p | tr -d \\n > entropy
```

with the entropy(hex) result:

```console
c5f198639915a101c99af326dffe13e8f14456be8fd2312a39a777b92178804e204ca4fee12a8667871440eff4288e811d86d746c6d96a60c919c3418dfebba42f329f5d73c0372d636d61d5dfda1add61af36c70e4acd771276107209e643ae92a0f43e95a452744e50fb4540d9bdf4e0b701725d7db488fbe18c1ab7737c6b
```

If you need a text file for hashcat to crack the password you have to combine the hash data you have found into a single string:

```
$ml$<iterations(integer)>$<salt(hex)>$<entropy(hex)>
```

With my example hash data that's:

```
$ml$49504$0dba6246bd38266b2e827ff7e7271380757c71d653893aa361d5902398302369$c5f198639915a101c99af326dffe13e8f14456be8fd2312a39a777b92178804e204ca4fee12a8667871440eff4288e811d86d746c6d96a60c919c3418dfebba42f329f5d73c0372d636d61d5dfda1add61af36c70e4acd771276107209e643ae92a0f43e95a452744e50fb4540d9bdf4e0b701725d7db488fbe18c1ab7737c6b
```

Save this to a file named hash.txt and use it in hashcat. The proper brute force command to find the password (=my simple test password only containing 4 digits) is:

```console
./hashcat-cli64.app -m 7100 hash.txt -a 3 ?d?d?d?d
```

The resulting password after 3 minutes cracking (in a VM) is 1111.

## Now the reverse: Creating ShadowHashData (valid in OS 10.8 and newer)

This elucidates why you can't use a simple SHA512 hash generator to create your "password" data. SHA512 is still important though. The background is explained here: PBKDF2-Key_derivation_process.

You need:

- PRF is a pseudorandom function of two parameters with output length hLen (e.g. a keyed HMAC)
- Password is the master password from which a derived key is generated
- Salt is a sequence of bits, known as a cryptographic salt
- c is the number of iterations desired
- dkLen is the desired length of the derived key

to create DK = PBKDF2(PRF, Password, Salt, c, dkLen)

To create DK ~ the entropy key in SALTED-SHA512-PBKDF2 (the only part in the intermediate plist that relies on your password) use php [hash_pbkdf2](http://php.net/manual/de/function.hash-pbkdf2.php):

```php
string hash_pbkdf2 ( string $algo , string $password , string $salt , int $iterations [, int $length = 0 [, bool $raw_output = false ]] )
```

In Terminal (PHP ⩾ 5.5 is needed) enter:

```php
php -a
Interactive shell

php > $password = "1111";
php > $iterations = 49504;
php > $length = 256;
php > $salt = "\x0d\xba\x62\x46\xbd\x38\x26\x6b\x2e\x82\x7f\xf7\xe7\x27\x13\x80\x75\x7c\x71\xd6\x53\x89\x3a\xa3\x61\xd5\x90\x23\x98\x30\x23\x69";
php > $hash = hash_pbkdf2("sha512", $password, $salt, $iterations, $length);
php > echo $hash;

c5f198639915a101c99af326dffe13e8f14456be8fd2312a39a777b92178804e204ca4fee12a8667871440eff4288e811d86d746c6d96a60c919c3418dfebba42f329f5d73c0372d636d61d5dfda1add61af36c70e4acd771276107209e643ae92a0f43e95a452744e50fb4540d9bdf4e0b701725d7db488fbe18c1ab7737c6b
php > 
```

The string used in $salt is the escaped hex (\x) presentation of salt(hex):
0dba6246... -> \x0d\xba\x62\x46...

Since you can define or know the hash algorithm (it has to be sha512 for Mac 10.8 and later), iterations (a number bigger than zero and smaller than 2^32-1), salt (length 64 bytes hex but random!) and length (256 byte) you can create a well-formed intermediate plist file, by reversing all commands above.

By reversing your command (better: each of the subcommands) from the very first step you can create the data of the key ShadowHashData in the original plist using the intermediate plist.

And to answer your question finally: the hash algorithm used to process the OS X password (and other data like the salt) is SHA512. But you can't say your user password is stored as SHA512 hash.

Your password and the salt is grilled by sha512 many times, then the result is base64'ed and reverse xxd'ed. Together with the salt and the iterations it's xxd'ed and base64'ed again.

I hope I didn't forget any step.
