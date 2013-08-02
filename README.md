# Radler: backups with the finest lemonade.

The idea is to have a small command line app that allows you to upload files to Amazon Glacier, and that also keeps track of them, because Glacier is kind of a pain in the ass when it comes to keeping track of files.

Note: there is actually no code written, but i'm explaining here how I want the app to work.

## Installation

    $ gem install radler

Then you could run something like ``radler config`` and paste in your amazon credentials and radler should store them in some file in your home folder.

## Usage

Note: there is actually no code written, but i'm explaining here how I want the app to work.

### Uploading files

You should create a folder with the files you want to back up and then run the ``radler`` command.
Radler should then create an [Amazon Glacier Vault](https://aws.amazon.com/glacier/faqs/#How_do_vaults_work) with the same name of the folder and put them in there.

It should keep track of the files ids and everything you might be interested in using [Amazon SimpleDB](https://aws.amazon.com/simpledb/), because who doesn't like databases that are simple and ***FREEEEE***?

### Reading backups metadata

You should be able to run ``radler list`` and the app should return all the backups that you have created.

### Retrieving backups

I actually haven't really learned how to recover information with Amazon Glacier yet, so as soon as I know i'll post it here.

Anyways, it should be something like ``radler recover backupname optional_file_name``

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

![Radler](http://i.imgur.com/9sWgiM3.jpg)
