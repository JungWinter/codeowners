# codeowners

## Usage

### inspect

Inspect codeowners should be removed in organization.

```console
$ codeowners inspect org
```

### replace

Replace codeowners old to new one.

```console
$ codeowners replace org a b
```

## Rules

If you want to replace `a` to `b`, command follows below rules.

|before|after|description|
|-|-|-|
|`* @a`|`* @b`||
|`* @A`|`* @b`|case insensitive|
|`* @b @c @a`|`* @b @c`|keep priority|
|`* @a @c @b`|`* @b @c`|promote to keep priority|
|`* @a/a @a @b`|`* @a/a @b`|distinguish team with member|
|`* @a @aa`|`* @b @aa`|match exactly|
|`*\t@a  @b\t\t@c`|`*\t@b  @c`|keep whitespaces|
|`* @a `|`* @b`|remove trailing whitespace|
|`* @a\na @a @b`|`* @b\na @b`|support multilines|
|`* @a\n# .github @a`|`* @b\n# .github @a`|ignore commented line|
