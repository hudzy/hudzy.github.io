---
layout: post
title: "Helm hasKey + ternary"
date: 2024-02-18
tags: [笔记, 工作]
---

```
feature_enabled_in_k8s_resource: {{ hasKey .Values "foo_feature_enabled" | ternary .Values.foo_feature_enabled true }}
```

### hasKey

The `hasKey` function returns `true` if the given dict contains the given key.

```
hasKey $myDict "name1"
```

If the key is not found, this returns `false`.

### ternary

The `ternary` function takes two values, and a test value. If the test value is true, the first value will be returned. If the test value is empty, the second value will be returned. This is similar to the ternary operator in C and other programming languages.

#### true test value

```
ternary "foo" "bar" true
```

or

```
true | ternary "foo" "bar"
```

The above returns `"foo"`.

#### false test value

```
ternary "foo" "bar" false
```

or

```
false | ternary "foo" "bar"
```

The above returns `"bar"`.

